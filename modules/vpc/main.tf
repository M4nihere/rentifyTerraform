resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
 
 tags = {
   Name = "Beanstalk-VPC"
 }
}


resource "aws_subnet" "Beanstalk-Public-Subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "Beanstalk-Public-Subnet1"
  }
}

resource "aws_subnet" "Beanstalk-Private-Subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "Beanstalk-Private-Subnet1"
  }
}

resource "aws_subnet" "Beanstalk-Public-Subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-2b"

  tags = {
    Name = "Beanstalk-Public-Subnet2"
  }
}

resource "aws_subnet" "Beanstalk-Private-Subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-southeast-2b"

  tags = {
    Name = "Beanstalk-Private-Subnet2"
  }
}