variable "ami" {
    description = "The ami of ec2"
    type = string
    default = "ami-008616ec4a2c6975e"
  
}

variable "instance_type" {
    description = "The instance type"
    type = string
    default = "t3.small"
  
}

variable "private_key_path" {
    description = "path to the ssh private key file"
    default = "C:/Users/SabaneDeepak/.ssh/id_rsa"
  
}

variable "public_key_path" {
  description = "Path to the SSH public key file"
  default     = "C:/Users/SabaneDeepak/provisioner_terraform/public_key.pub"  # Update with your actual public key file path
}
