# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "daves-demo-terraform-backend"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}

provider "aci" {
  # cisco-aci user name
  username = "admin"
  # cisco-aci password
  password = "ciscopsdt"
  # cisco-aci url
  url      = "https://sandboxapicdc.cisco.com"
  insecure = true
}

resource "aci_tenant" "main" {
  name        = "terraform-demo"
  description = "Created using Terraform"
}

resource "aci_application_profile" "main" {
  tenant_dn   = aci_tenant.main.id
  name        = "web-app"
  description = "Created using Terraform"
}

resource "aci_application_epg" "main" {
  application_profile_dn = aci_application_profile.main.id
  name                   = "test-app-001"
  description = "Created using Terraform"
}
