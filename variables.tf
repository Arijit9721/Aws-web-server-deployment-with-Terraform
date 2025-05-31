variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "cidr range of the vpc"
}

variable "subnet_cidr" {
  default     = "10.0.0.0/24"
  description = "cidr range of the subnet"
}

variable "subnet_az" {
  default     = "us-east-1a"
  description = "availability zone of the subnet"
}

# generate the key with "ssh-keygen -t rsa" and then add the file path of the public key
variable "public_key" {
    default = "~/.ssh/test_key.pub"
    description = "file path of the public key"
}

# the private key of the key pair(taken from tfvars)
variable "private_key" {
  default     = ""
  description = "file path to the private key"
}
