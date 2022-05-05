resource "aws_route_table" "iwayq_rt_pub" {
  vpc_id = aws_vpc.iwayqvpc.id

   tags = {
    Name = var.project
  }
}


# VPC creation
resource "aws_vpc" "iwayqvpc" {
  instance_tenancy = var.instance_tenancy
  cidr_block       = var.vpc_cidr

  tags = {
    Name = var.project
  }
}

resource "aws_subnet" "iwayq_pub_sub" {
  vpc_id     = aws_vpc.iwayqvpc.id
  cidr_block = var.cidr_pub_subnet
  availability_zone = var.pub_availability_zone

  tags = {
    Name = var.project
  }
}

resource "aws_subnet" "iwayq_priv_sub" {
  vpc_id     = aws_vpc.iwayqvpc.id
  cidr_block = var.cidr_priv_subnet
  availability_zone = var.priv_availability_zone

  tags = {
    Name = var.project
  }
}

resource "aws_route_table" "iwayq_rt_pri" {
  vpc_id = aws_vpc.iwayqvpc.id

   tags = {
    Name = var.project
  }
}

resource "aws_route" "iwayq_pub_route" {
  route_table_id            = aws_route_table.iwayq_rt_pub.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.iwayqigw.id
  depends_on                = [aws_route_table.iwayq_rt_pub]
}

resource "aws_route_table_association" "pub-sub-rt" {
  subnet_id      = aws_subnet.iwayq_pub_sub.id
  route_table_id = aws_route_table.iwayq_rt_pub.id
}

resource "aws_route_table_association" "priv-sub-rt" {
  subnet_id      = aws_subnet.iwayq_priv_sub.id
  route_table_id = aws_route_table.iwayq_rt_pri.id
}