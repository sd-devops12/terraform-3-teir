resource "aws_instance" "web" {
  ami           = "ami-01e82af4e524a0aa3"
  instance_type = "t2.micro"
  key_name = "oregon"
  subnet_id = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

  tags = {
    Name = "WebServer"
  }

  provisioner "file" {
    source = "./oregon.pem"
    destination = "/home/ec2-user/oregon.pem"

    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = "${file("./oregon.pem")}"
    }
  }
}

resource "aws_instance" "db" {
  ami           = "ami-01e82af4e524a0aa3"
  instance_type = "t2.micro"
  key_name = "oregon"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}
