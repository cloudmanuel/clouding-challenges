# Step 7: Output the public IP of the EC2 instance (for verification)
output "instance_public_ip" {
  value = aws_instance.main_instance.public_ip
}