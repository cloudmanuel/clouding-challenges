# Challenge 5

*Clean up your resources after use!*

To access your ec2 without needing to ssh, use ssm session manager.

## Scenario:

A user has launched an EC2 instance in AWS and is trying to connect to external websites and update packages using yum update. However, the update fails with the following error message:

```Error: Failed to connect to the internet. Unable to resolve host.```

The user is able to connect to the instance via SSM but is unable to ping any external IP addresses or download software. The user also confirms that the instance has a public IP address and that the security group is configured to allow all outbound traffic.

What you need to troubleshoot:

The engineer is tasked with diagnosing why the EC2 instance cannot connect to the internet. You will need to:

1) Verify that the instance has a valid public IP (if applicable).
2) Check the security group configuration to confirm that outbound traffic is not blocked.
3) Review the VPC, subnet, and route table configuration to ensure that the EC2 instance can route traffic as needed.