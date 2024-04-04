# Internet Gateway (for Public Route Table)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Beanstalk-IG"
  }
}

# Route for Public Route Table (to Internet Gateway)
resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block     = "0.0.0.0/0"
  gateway_id     = aws_internet_gateway.gw.id
}