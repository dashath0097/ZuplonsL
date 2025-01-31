provider "aws" {
  aws_access_key_id = YOUR_ACCESS_KEY
  aws_secret_access_key = YOUR_SECRET_KEY
  region = "us-east-1"  # Adjust your region
  profile = "default"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0c614dee691cbbf37"  # Replace with your preferred AMI
  instance_type = "t2.micro"

  tags = {
    Name = "MySpaceliftInstance"
  }
}
