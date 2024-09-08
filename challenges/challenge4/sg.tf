# Create a Security Group for the EC2 instance
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}