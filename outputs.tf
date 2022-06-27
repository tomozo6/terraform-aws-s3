output "bucket" {
  value = aws_s3_bucket.mod.bucket
}

output "arn" {
  value = aws_s3_bucket.mod.arn
}

output "bucket_domain_name" {
  value = aws_s3_bucket.mod.bucket_domain_name
}

output "website_endpoint" {
  value = try(aws_s3_bucket_website_configuration.mod[0].website_endpoint, null)
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.mod.bucket_regional_domain_name
}
