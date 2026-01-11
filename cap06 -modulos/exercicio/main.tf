
provider "aws" {
  region     = "us-east-1"
  access_key = "test"
  secret_key = "test"

  # Configurações obrigatórias para LocalStack
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3             = "http://localstack:4566"
    dynamodb       = "http://localstack:4566"
    lambda         = "http://localstack:4566"
    ec2            = "http://localstack:4566"
    # Adicione outros serviços conforme necessário
  }
}

module "vpc_instances" {
  
  source = "./modules/network"

  vpc_name = "dsa-network"
}

module "dsa_ec2_instances" {
  
  source = "./modules/ec2-instances"

  instance_count = 2
  ami_id         = "ami-0a0d9cf81c479446a"
  instance_type  = "t2.micro"
  subnet_id = module.vpc_instances.public_subnet_id
}

module "dsa_s3_bucket" {

  source = "./modules/s3-bucket"

  bucket_name = "dsa-meu-unico-bucket-lab2"
  tags        = {"Data Science" = "Academy"}
}
