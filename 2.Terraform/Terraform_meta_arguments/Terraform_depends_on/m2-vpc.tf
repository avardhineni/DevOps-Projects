resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-dev"
  }
}

resource "aws_subnet" "pubsub" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
}

resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_route_table" "vpc-prt" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_route" "vpc-route" {

  route_table_id         = aws_route_table.vpc-prt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc-igw.id
}

resource "aws_route_table_association" "vpc-sub-assoc" {
  route_table_id = aws_route_table.vpc-prt.id
  subnet_id      = aws_subnet.pubsub.id
}

resource "aws_security_group" "vpc-sg" {
  name        = "dev-sg"
  description = "dev VPC Security Group"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all IP and Ports Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


