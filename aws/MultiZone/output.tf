output "bastion-public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion-public_dns" {
  value = aws_instance.bastion.public_dns
}

output "frontend-alb-public_dns" {
  value = aws_lb.windfire-frontend-alb.dns_name
}

output "backend-alb-public_dns" {
  value = aws_lb.windfire-backend-alb.dns_name
}