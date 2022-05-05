
output "vpc_id" {
  value = aws_vpc.megavpc.id
}

output "mega_pub_sub_id" {
  value = aws_subnet.mega_pub_sub.id
}