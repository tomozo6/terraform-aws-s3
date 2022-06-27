# terraform-aws-s3

## 使用方法

### シンプルに構築する際

```hcl
module "example" {
  source = "git@github.com:isrelab/terraform-aws-s3.git?ref=vX.X.X"
  tags   = local.tags
  role   = "example"
}
```

### ALBやCloudTrailなどのLog保管用S3

```hcl
module "s3logbucket" {
  source = "git@github.com:isrelab/terraform-aws-s3.git?ref=vX.X.X"
  tags   = local.tags
  role   = "logs"
  acl    = "log-delivery-write"
}
```

### バケットポリシーを設定したい場合

```hcl
module "example" {
  source = "git@github.com:isrelab/terraform-aws-s3.git?ref=vX.X.X"
  tags   = local.tags
  role   = "example"
  policy = file("files/example-s3-policy.json")
}
```

### バージョニングを設定したい場合

```hcl
module "example" {
  source            = "git@github.com:isrelab/terraform-aws-s3.git?ref=vX.X.X"
  tags              = local.tags
  role              = "example"
  versioning_status = "Enabled"
}
```

### 静的ウェブサイトホスティングを設定したい場合

```hcl
module "example" {
  source      = "git@github.com:isrelab/terraform-aws-s3.git?ref=vX.X.X"
  tags        = local.tags
  bucket_name = "test.example.com"
  log_bucket  = module.s3logbucket.bucket
  acl         = "public-read"
}
```
