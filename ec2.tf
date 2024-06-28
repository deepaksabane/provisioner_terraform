resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "mysubnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"  # Update with your desired AZ

  tags = {
    Name = "main-subnet"
  }
}

resource "aws_instance" "deepak-forever" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name  # Use the key_name from aws_key_pair resource
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.mysubnet.id

   provisioner "file" {
    source      = "C:/Users/SabaneDeepak/provisioner_terraform/test-file"
    destination = "/home/ubuntu/test-file"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = file(var.private_key_path)  # Update with correct path to your private key
    timeout     = "4m"
  }
}

resource "aws_security_group" "main" {
  name        = "main_tls"
  description = "allow port 22 and all"

  vpc_id = aws_vpc.main.id

  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = ""
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = ""
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"  # Provide a meaningful name for your key pair
  public_key = file(var.public_key_path)

}