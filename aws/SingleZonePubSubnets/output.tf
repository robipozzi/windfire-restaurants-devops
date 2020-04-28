output "bastion-public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}
output "bastion-public_dns" {
  value = "${aws_instance.bastion.public_dns}"
}
output "backend-public_ip" {
  value = "${aws_instance.backend.public_ip}"
}
output "backend-public_dns" {
  value = "${aws_instance.backend.public_dns}"
}