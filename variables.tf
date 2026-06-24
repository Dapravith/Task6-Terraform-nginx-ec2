variable "aws_region" {
  description = "AWS region to create EC2 instance"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for resource tags"
  type        = string
  default     = "terraform-static-website"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "github_repo_url" {
  description = "Public GitHub repository URL containing static website files"
  type        = string
  default     = "https://github.com/Dapravith/Task6-Terraform-nginx-ec2.git"
}

variable "ssh_allowed_cidr" {
  description = "CIDR allowed to SSH into EC2. Use your public IP for better security."
  type        = string
  default     = "0.0.0.0/0"
}

variable "key_name" {
  description = "Name for the EC2 key pair that Terraform creates"
  type        = string
  default     = "terraform-key"
}

variable "public_key_path" {
  description = "Path to the local SSH public key imported into the EC2 key pair"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "root_volume_size" {
  description = "Size of the root EBS volume in GiB"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Type of the root EBS volume"
  type        = string
  default     = "gp3"
}