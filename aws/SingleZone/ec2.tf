#######################################################
################### Start - AWS EC2 ###################
#######################################################
resource "aws_instance" "windfire-web" {
  ami             = var.ami
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.windfire-frontend-securitygroup.id]
  subnet_id       = aws_subnet.windfire-frontend-subnet.id
  key_name        = var.key_name

  # Run install-httpd.sh script, provided in scripts sub-folder, at EC2 instance launch time
  user_data = file("scripts/install-httpd.sh")
  tags = {
    Name = "Web Server"
    Role = "frontend"
  }
}

resource "aws_instance" "windfire-backend" {
  ami             = var.ami
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.windfire-backend-securitygroup.id]
  subnet_id       = aws_subnet.windfire-backend-subnet.id
  key_name        = var.key_name

  # Run install-node.sh script, provided in scripts sub-folder, at EC2 instance launch time
  user_data = file("scripts/install-node.sh")
  tags = {
    Name = "Backend Server"
    Role = "backend"
  }
}

resource "aws_instance" "bastion" {
  ami             = var.ami
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.windfire-bastion-securitygroup.id]
  subnet_id       = aws_subnet.windfire-bastion-subnet.id
  key_name        = var.key_name
  tags = {
    Name = "Bastion Host"
    Role = "bastion"
  }
}
#####################################################
################### End - AWS EC2 ###################
#####################################################
/*resource "aws_key_pair" "windfire-keypair" {
  key_name   = "${var.keypair["key_name"]}"
  public_key = "${file("${var.keypair["publickey"]}")}"
}*/