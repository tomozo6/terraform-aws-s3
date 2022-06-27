data "aws_elb_service_account" "main" {}
locals {
  name = var.bucket_name != null ? var.bucket_name : replace(format("%s-%s-%s-s3-%s", var.tags.project, var.tags.env, var.role, var.suffix), "/-$/", "")
}

# -----------------------------------------------------------------------
# S3
# -----------------------------------------------------------------------
resource "aws_s3_bucket" "mod" {
  bucket        = local.name
  force_destroy = var.force_destroy
  tags          = var.tags
}

# -----------------------------------------------------------------------
# Enable Default Server Side Encryption
# -----------------------------------------------------------------------
resource "aws_s3_bucket_server_side_encryption_configuration" "mod" {
  count  = var.encryption_enabld ? 1 : 0
  bucket = aws_s3_bucket.mod.bucket

  rule {
    bucket_key_enabled = var.bucket_key_enabled

    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
      kms_master_key_id = var.kms_master_key_id
    }
  }
}

# -----------------------------------------------------------------------
# Bucket ACL
# -----------------------------------------------------------------------
# ACL無効化が推奨されている
resource "aws_s3_bucket_ownership_controls" "mod" {
  bucket = aws_s3_bucket.mod.bucket

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_acl" "mod" {
  count  = var.acl == null ? 0 : 1
  bucket = aws_s3_bucket.mod.bucket
  acl    = var.acl
}

# -----------------------------------------------------------------------
# Bucket Policy
# -----------------------------------------------------------------------
#resource "aws_s3_bucket_policy" "mod" {
#  count = var.policy == null ? var.acl == "private" ? 0 : 1 : 1
#  bucket = aws_s3_bucket.mod.bucket
#
#  policy = var.acl != "log-delivery-write" ? var.acl != "public-read" ? var.policy : templatefile("${path.module}/files/bucket-policy-public.json", {
#    bucket_name = local.name,
#    }) : templatefile("${path.module}/files/bucket-policy-logs.json", {
#    bucket_name     = local.name,
#    elb_account_arn = data.aws_elb_service_account.main.arn
#  })
#}

# -----------------------------------------------------------------------
# Public Access Block
# -----------------------------------------------------------------------
resource "aws_s3_bucket_public_access_block" "mod" {
  bucket                  = aws_s3_bucket.mod.bucket
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

# -----------------------------------------------------------------------
# Versioning
# -----------------------------------------------------------------------
resource "aws_s3_bucket_versioning" "mod" {
  bucket = aws_s3_bucket.mod.id
  versioning_configuration {
    status     = var.versioning_status
    mfa_delete = var.versioning_mfa_delete
  }
}

# -----------------------------------------------------------------------
# Website Configuration
# -----------------------------------------------------------------------
resource "aws_s3_bucket_website_configuration" "mod" {
  count  = var.website_enabld ? 1 : 0
  bucket = aws_s3_bucket.mod.bucket

  index_document {
    suffix = var.index_document_suffix
  }

  error_document {
    key = var.error_document_key
  }
}

# -----------------------------------------------------------------------
# Logging
# -----------------------------------------------------------------------
#resource "aws_s3_bucket_logging" "mod" {
#  count  = var.acl != "public-read" ? 0 : 1
#  bucket = aws_s3_bucket.mod.id
#
#  target_bucket = var.log_bucket
#  target_prefix = "s3/domain=${local.name}/"
#}
