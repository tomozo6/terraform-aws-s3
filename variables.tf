# -----------------------------------------------------------------------
# Tags
# -----------------------------------------------------------------------
variable "tags" {
  type    = map(any)
  default = {}
}

variable "role" {
  type    = string
  default = ""
}

variable "suffix" {
  type    = string
  default = ""
}

# -----------------------------------------------------------------------
# S3 Bucket
# -----------------------------------------------------------------------
variable "bucket_name" {
  type    = string
  default = null
}

variable "force_destroy" {
  type    = bool
  default = false
}

# -----------------------------------------------------------------------
# Enable Default Server Side Encryption
# -----------------------------------------------------------------------
variable "encryption_enabld" {
  type    = bool
  default = true
}

variable "bucket_key_enabled" {
  type    = bool
  default = true
}

variable "sse_algorithm" {
  type    = string
  default = "AES256"
}

variable "kms_master_key_id" {
  type    = string
  default = null
}

# -----------------------------------------------------------------------
# Bucket ACL
# -----------------------------------------------------------------------
variable "object_ownership" {
  type    = string
  default = "BucketOwnerEnforced"
}

variable "acl" {
  type    = string
  default = null
}

# -----------------------------------------------------------------------
# Bucket Policy
# -----------------------------------------------------------------------
variable "policy" {
  type    = string
  default = null
}

# -----------------------------------------------------------------------
# Public Access Block
# -----------------------------------------------------------------------
variable "block_public_acls" {
  type    = bool
  default = false
}

variable "block_public_policy" {
  type    = bool
  default = false
}

variable "ignore_public_acls" {
  type    = bool
  default = false
}

variable "restrict_public_buckets" {
  type    = bool
  default = false
}

# -----------------------------------------------------------------------
# Versioning
# -----------------------------------------------------------------------
variable "versioning_status" {
  type    = string
  default = "Disabled"
}

variable "versioning_mfa_delete" {
  type    = string
  default = null
}

# -----------------------------------------------------------------------
# Website Configuration
# -----------------------------------------------------------------------
variable "website_enabled" {
  type    = bool
  default = false
}

variable "index_document_suffix" {
  type    = string
  default = "index.html"
}

variable "error_document_key" {
  type    = string
  default = "error.html"
}

# -----------------------------------------------------------------------
# Logging
# -----------------------------------------------------------------------
variable "log_bucket" {
  type    = string
  default = null
}
