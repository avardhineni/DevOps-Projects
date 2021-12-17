resource "aws_instance" "dev-ec2" {
  ami                    = "ami-0ed9277fb7eb570c9"
  instance_type          = "t2.micro"
  key_name               = "avkaws3"
  count                  = 2
  subnet_id              = aws_subnet.pubsub.id
  vpc_security_group_ids = [aws_security_group.vpc-sg.id]
  user_data              = file("apache-install.sh")
  tags = {
    "Name" = "dev-${count.index}"
  }
}
