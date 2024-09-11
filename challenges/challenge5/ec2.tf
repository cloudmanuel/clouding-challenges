# Step 6: Create a free tier-eligible EC2 instance
resource "aws_instance" "main_instance" {
  ami           = "ami-0182f373e66f89c85"  # Amazon Linux 2 AMI (Free Tier eligible), region specific
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main_subnet.id
  vpc_security_group_ids = [aws_security_group.main_sg.name]
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_instance_profile.name

  tags = {
    Name = "${var.challenge}-Instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello World from the EC2 instance" > /var/www/html/index.html
              EOF
}