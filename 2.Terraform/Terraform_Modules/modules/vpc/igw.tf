resource "aws_internet_gateway" "iwayqigw" {
  vpc_id = aws_vpc.iwayqvpc.id

  tags = {
    Name = var.project
  }
}