# Assign TF Provider
provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}
	
#resource generate random password for VestaCP Install
  resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
  }
  
# Call userdata template
	data "template_file" "user_data" {
	template = "${file("userdata.tpl")}"
}

# Create a new AWS Instance and attach keypair
resource "aws_instance" "vestacp" {
  ami             = "ami-0083662ba17882949"
  instance_type   = "t2.micro"
  key_name        = "vantz-tf-stuff"
  user_data       = "${data.template_file.user_data.template}"
  tags = {
	Name = "Vantz-TF-Test"
	}
}

# Configure VPC
resource "aws_vpc" "vantz-tf-test" {
  cidr_block = "10.0.0.0/24"
  tags = {
  Name = "vantz-tf-stuff"
  }
}

# Configure open ports in SG
resource "aws_security_group" "vantz-tf-test" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = "${aws_vpc.vantz-tf-test.id}"

# Inbound SG Settings
  ingress {
    # HTTP (change to whatever ports you need)
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["75.178.114.217/32"]
  }
    ingress {
    # HTTPS (change to whatever ports you need)
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["75.178.114.217/32"]
  }
    ingress {
    # VestaCP Management Port (change to whatever ports you need)
    from_port   = 8083
    to_port     = 8083
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["75.178.114.217/32"]
  }
    ingress {
    # SSH (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["75.178.114.217/32"]
  }
  
# Outbound SG Settings
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
	Name = "Vantz-TF-Test"
	}
}