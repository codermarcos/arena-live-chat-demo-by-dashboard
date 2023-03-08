locals {
  package     = jsondecode(file("../package.json"))
  dist_dir    = local.package.config.out
  project     = local.package.name
  region      = "us-east-1"

  env_name = get_env("ENV_NAME", "local")

  aws_state_bucket_region = get_env("AWS_STATE_BUCKET_REGION", "us-east-1")

  id = substr(md5(format("%s%s", local.project, local.aws_state_bucket_region)), 0, 10)

  aws_state_bucket        = "${local.id}-${local.aws_state_bucket_region}-${local.project}-terragrunt"
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.30"
    }
    null = {}
    local = {}
  }
}

provider "aws" {
  region      = "${local.region}"

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true

  # skip_requesting_account_id should be disabled to generate valid ARN in apigatewayv2_api_execution_arn
  skip_requesting_account_id = false
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket  = local.aws_state_bucket
    key     = "${local.project}/${path_relative_to_include()}/terraform.tfstate"
    region  = local.aws_state_bucket_region
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

terraform {
  source = ".//main"
}

inputs = {
  region      = local.region
  env_name    = local.env_name
  dist_dir    = abspath(local.dist_dir)
  project     = "${local.id}-${local.aws_state_bucket_region}-${local.project}"
}
