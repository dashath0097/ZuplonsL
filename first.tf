provider "aws" {
  region = "us-east-1"  # Adjust your region
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with your preferred AMI
  instance_type = "t2.micro"

  tags = {
    Name = "MySpaceliftInstance"
  }
}
