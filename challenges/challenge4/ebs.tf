# Create an EBS volume
resource "aws_ebs_volume" "web_volume" {
  availability_zone = "us-east-1b"
  size              = 8            # Free tier eligible EBS volume
  tags = {
    Name = "WebVolume"
  }
}

# # Attempt to attach the EBS volume to the EC2 instance
# resource "aws_volume_attachment" "web_volume_attachment" {
#   device_name = "/dev/xvdf"
#   volume_id   = aws_ebs_volume.web_volume.id
#   instance_id = aws_instance.web.id
#   force_detach = true
# }