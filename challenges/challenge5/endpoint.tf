# Create Interface Endpoint for SSM
resource "aws_vpc_endpoint" "ssm_endpoint" {
  vpc_id            = aws_vpc.main_vpc.id
  service_name      = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"  # Interface type requires subnet_ids

  subnet_ids         = [aws_subnet.main_subnet.id]
  security_group_ids = [aws_security_group.endpoint_sg.id]

  private_dns_enabled = true

  tags = {
    Name = "SSMInterfaceEndpoint"
  }
}

# Create Interface Endpoint for EC2 Messages
resource "aws_vpc_endpoint" "ec2_messages_endpoint" {
  vpc_id            = aws_vpc.main_vpc.id
  service_name      = "com.amazonaws.us-east-1.ec2messages"
  vpc_endpoint_type = "Interface"

  subnet_ids         = [aws_subnet.main_subnet.id]
  security_group_ids = [aws_security_group.endpoint_sg.id]

  private_dns_enabled = true

  tags = {
    Name = "EC2MessagesInterfaceEndpoint"
  }
}

resource "aws_vpc_endpoint" "ssm_message_endpoint" {
  vpc_id            = aws_vpc.main_vpc.id
  service_name      = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type = "Interface"

  subnet_ids         = [aws_subnet.main_subnet.id]
  security_group_ids = [aws_security_group.endpoint_sg.id]

  private_dns_enabled = true
}

resource "aws_security_group" "endpoint_sg" {
  vpc_id = aws_vpc.main_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.main_sg.id]
  }



  tags = {
    Name = "${var.challenge}-SecurityGroup"
  }
}