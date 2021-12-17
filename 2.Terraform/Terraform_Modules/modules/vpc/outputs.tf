
output "vpc_id" {
  value = aws_vpc.iwayqvpc.id
}

output "iwayq_pub_sub_id" {
  value = aws_subnet.iwayq_pub_sub.id
}