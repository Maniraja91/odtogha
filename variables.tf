variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "public_key" {
  description = "Public key content for the key pair"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the Windows Server"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t3.medium"
}

variable "volume_size" {
  description = "Root volume size in GiB"
  type        = number
  default     = 100
}