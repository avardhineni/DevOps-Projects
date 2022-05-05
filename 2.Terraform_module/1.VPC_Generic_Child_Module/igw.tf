resource "aws_internet_gateway" "megaigw" {
  vpc_id = aws_vpc.megavpc.id

  tags = {
    Name = var.project
  }
}