output "SG_Id" {
  value = aws_security_group.public_SG.id
}
output "pub_sub_id" {
  value = aws_subnet.pub_subnet.id
}
