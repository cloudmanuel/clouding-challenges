# Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Allow all outbound traffic"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Allow traffic"
  vpc_id      = aws_vpc.main.id

  ingress = {
    from_port = 3396
    to_port   = 3396
    protocol  = "-1"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  # No ingress rule to allow traffic from EC2
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}