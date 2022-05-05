resource "aws_route_table" "mega_rt_pub" {
  vpc_id = aws_vpc.megavpc.id

   tags = {
    Name = var.project
  }
}


# VPC creation
resource "aws_vpc" "megavpc" {
  instance_tenancy = var.instance_tenancy
  cidr_block       = var.vpc_cidr

  tags = {
    Name = var.project
  }
}

resource "aws_subnet" "mega_pub_sub" {
  vpc_id     = aws_vpc.megavpc.id
  cidr_block = var.cidr_pub_subnet
  availability_zone = var.pub_availability_zone

  tags = {
    Name = var.project
  }
}

resource "aws_subnet" "mega_priv_sub" {
  vpc_id     = aws_vpc.megavpc.id
  cidr_block = var.cidr_priv_subnet
  availability_zone = var.priv_availability_zone

  tags = {
    Name = var.project
  }
}

resource "aws_route_table" "mega_rt_pri" {
  vpc_id = aws_vpc.megavpc.id

   tags = {
    Name = var.project
  }
}

resource "aws_route" "mega_pub_route" {
  route_table_id            = aws_route_table.mega_rt_pub.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.megaigw.id
  depends_on                = [aws_route_table.mega_rt_pub]
}

resource "aws_route_table_association" "pub-sub-rt" {
  subnet_id      = aws_subnet.mega_pub_sub.id
  route_table_id = aws_route_table.mega_rt_pub.id
}

resource "aws_route_table_association" "priv-sub-rt" {
  subnet_id      = aws_subnet.mega_priv_sub.id
  route_table_id = aws_route_table.mega_rt_pri.id
}