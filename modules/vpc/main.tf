# AWS VPC
resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
 
 tags = {
   Name = "Beanstalk-VPC"
 }
}

#Public And Private Subnets 
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


# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Beanstalk-Public-Route-Table"
  }
}

# Public Route Table Association (for Public Subnets)

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Beanstalk-Private-Route-Table"
  }
}

# Internet Gateway (for Public Route Table)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Beanstalk-Internet-Gateway"
  }
}

# Route for Public Route Table (to Internet Gateway)
resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block     = "0.0.0.0/0"
  gateway_id     = aws_internet_gateway.gw.id
}