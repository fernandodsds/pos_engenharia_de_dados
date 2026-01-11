# 1. Criar a VPC
resource "aws_vpc" "local_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# 2. Criar uma Subnet Pública
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.local_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet-Publica-${var.vpc_name}"
  }
}

# 3. Criar uma Subnet Privada
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.local_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Subnet-Privada-${var.vpc_name}"
  }
}