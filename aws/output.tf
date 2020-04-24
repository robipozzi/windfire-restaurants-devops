output "bastion-public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}
output "bastion-public_dns" {
  value = "${aws_instance.bastion.public_dns}"
}
output "backend-private_ip" {
  value = "${aws_instance.windfire-backend.private_ip}"
}