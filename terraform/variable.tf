variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}


variable "public_subnet_cidrs" {
  description = "Two public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "ssh_allowed_cidrs" {
  description = "CIDRs allowed to SSH to EC2 instances"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}


variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}


variable "rds_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}


variable "rds_password" {
  description = "RDS master password (use Secrets Manager/SSM in real projects)"
  type        = string
  sensitive   = true
  default     = "ChangeMeStrong!123"
}


variable "eks_version" {
  description = "EKS control plane version"
  type        = string
  default     = "1.30"
}