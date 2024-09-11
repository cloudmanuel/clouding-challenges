# EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-0a91cd140a1fc148a" # Amazon Linux 2 AMI (Free Tier eligible), region specific
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.ec2_sg.name]
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_instance_profile.name

  tags = {
    Name = "WebServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum install -y mysql
              EOF
}