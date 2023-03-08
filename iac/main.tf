variable "project" {
  description = "Name of the project"
  type        = string
}

variable "dist_dir" {
  description = "Dist folder to deploy"
  type        = string
}

locals {
  mime_type_mappings = {
    html = "text/html",
    png  = "image/png",
  }
}

resource "aws_s3_bucket" "frontend_bucket" {
  acl           = "public-read"
  force_destroy = true
  bucket        = var.project

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  policy = <<EOF
{
  "Id": "bucket_policy_site",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_policy_site_main",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.project}/*",
      "Principal": "*"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_object" "frontend_object" {
  for_each = fileset(var.dist_dir, "**")
  key      = each.value
  source   = "${var.dist_dir}/${each.value}"
  bucket   = aws_s3_bucket.frontend_bucket.bucket

  force_destroy = true
  etag          = filemd5("${var.dist_dir}/${each.value}")
  content_type  = local.mime_type_mappings[concat(regexall("\\.([^\\.]*)$", each.value), [[""]])[0][0]]
}

output "static_files_folder" {
  value = var.dist_dir
}

output "website_domain" {
  value = aws_s3_bucket.frontend_bucket.website_domain
}

output "website_endpoint" {
  value = aws_s3_bucket.frontend_bucket.website_endpoint
}
