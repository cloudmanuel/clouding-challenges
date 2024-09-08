### Solution:

You will find out that the volume is in a different availability zone than the ec2 instance, depending on whats required:

1) Remake the new instance in the correct AZ to match the volume

2) Make a snapshot of the volume in the correct AZ (https://repost.aws/articles/ARkmirs-YtQUmKMA-jt2lhkA/availability-zone-az-migration-instance-upgrade-guide)

3) If these are all new resources fix the terraform to match AZ's

Common troubleshooting issues with ebs mounting: (https://repost.aws/knowledge-center/ebs-resolve-attach-volume-instance-issue)


In terraform if you had a mismatch in the resources it would output something similiar to the following: 

```
│ Error: attaching EBS Volume (vol-09123a2b9bfcdf9c3) to EC2 Instance (i-0823ba816644f579e): operation error EC2: AttachVolume, https response error StatusCode: 400, RequestID: 0c4dad12-c61d-4036-96a3-cefa77ba84f5, api error InvalidVolume.ZoneMismatch: The volume 'vol-09123a2b9bfcdf9c3' is not in the same availability zone as instance 'i-0823ba816644f579e'
│ 
│   with aws_volume_attachment.web_volume_attachment,
│   on ebs.tf line 11, in resource "aws_volume_attachment" "web_volume_attachment":
│   11: resource "aws_volume_attachment" "web_volume_attachment" { }

```

Which is why I needed it to be created in console. The aws_subnet resource doesnt require you to specify the availability zone which could cause issues while some of the other resources do, thus terraform can be tricky as well. 

[Terraform Document] (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)