# Launch an EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-0182f373e66f89c85" # Amazon Linux 2 AMI (Free Tier eligible)
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.main_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "WebServer"
  }
}
