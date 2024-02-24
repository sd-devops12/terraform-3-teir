resource "aws_eip" "myeip" {
  //instance = aws_instance.web.id
  domain = "vpc"
}
