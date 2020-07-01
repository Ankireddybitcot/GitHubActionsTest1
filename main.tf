# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.11.13"
  backend "s3" {
    bucket         = "ankisatte"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    #dynamodb_table = "aws-locks"
    encrypt        = true
  }
}

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = "us-west-2"
  version = "~> 2.36.0"
}


# Commented out until after bootstrap

# Call the seed_module to build our ADO seed info
module "bootstrap" {
  source                      = "./modules/bootstrap"
  name_of_s3_bucket           = "ankisatte"
  dynamo_db_table_name        = "aws-locks"
  iam_user_name               = "GitHubActionsIamUser"
  ado_iam_role_name           = "GitHubActionsIamRole"
  aws_iam_policy_permits_name = "GitHubActionsIamPolicyPermits"
  aws_iam_policy_assume_name  = "GitHubActionsIamPolicyAssume"
}

resource "aws_budgets_budget" "budget" {
  name              = "${var.name}"
  budget_type       = "COST"
  limit_amount      = "${var.limitamount}"
  limit_unit        = "USD"
  cost_types{
    include_recurring = true
  }
  time_period_start = "2020-01-01_00:00"
  time_unit         = "MONTHLY"
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = "${var.threshold}"
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["${var.email}"]
  }
}
