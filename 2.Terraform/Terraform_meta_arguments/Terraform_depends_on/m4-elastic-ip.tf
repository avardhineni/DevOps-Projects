resource "aws_eip" "dev-eip" {
  depends_on = [aws_internet_gateway.vpc-igw]
  instance   = aws_instance.dev-ec2.id
  vpc        = true
}