terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_security_group" "minecraft_security_group" {
  name        = "minecraft_security_group"
  description = "Allow SSH and Minecraft inbound traffic and all IPv4 outbound traffic"

  tags = {
    Name = "minecraft_security_group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.minecraft_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_minecraft" {
  security_group_id = aws_security_group.minecraft_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 25565
  ip_protocol       = "tcp"
  to_port           = 25565
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.minecraft_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = "generated_key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "aws_instance" "app_server" {
  ami           = "ami-05d2ed97ce7162747"
  instance_type = "t4g.small"
  vpc_security_group_ids = [aws_security_group.minecraft_security_group.id]
  key_name      = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true

  provisioner "file" {
    source = "scripts"
    destination = "/home/ec2-user/scripts"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ec2_key.private_key_pem
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/scripts/setup_mc_server.sh",
      "sudo /home/ec2-user/scripts/setup_mc_server.sh",
      "chmod +x /home/ec2-user/scripts/setup_auto_start.sh",
      "sudo /home/ec2-user/scripts/setup_auto_start.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ec2_key.private_key_pem
      host        = self.public_ip
    }
  }
  tags = {
    Name = "Minecraft_Server"
  }
}
