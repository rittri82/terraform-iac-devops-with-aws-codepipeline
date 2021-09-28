# Input Variables

# AWS Region

variable "aws_region" {
  type        = string
  default     = "ap-southeast-1"
  description = "Region in which AWS resource to be created"
}

# Environment Variable
variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment variable used as a prefix"
}

# Business Division
variable "business_division" {
  type        = string
  default     = "SAP"
  description = "depicts about the division the infra is getting setup for"
}