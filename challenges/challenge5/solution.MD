#### **Troubleshooting Approach and Tips**:
1. **Check Instance Connectivity**: 
   - Ensure the EC2 instance has a public IP and that it is in a public subnet.
   - Test basic connectivity by SSHing into the instance and attempting to ping a known IP (e.g., Google's public DNS: `ping 8.8.8.8`).

2. **Verify Security Group Rules**:
   - Check the security group associated with the EC2 instance. Ensure that outbound traffic on all ports is allowed (`0.0.0.0/0`).
   - Use the AWS Management Console or CLI (`aws ec2 describe-security-groups`) to confirm the rules.

3. **Check the Subnet and Route Table**:
   - Go to the VPC settings and check the route table associated with the subnet.
   - Ensure there is a route that directs traffic from `0.0.0.0/0` (anywhere) to the **Internet Gateway**.
   - If the route is missing, add it.

4. **Test Connectivity After Fixing the Route**:
   - After updating the route table, SSH into the EC2 instance again and test internet access by running `yum update` or trying to `curl` a website.
   
5. **Common Mistakes to Watch For**:
   - Forgetting to attach the Internet Gateway to the VPC.
   - Incorrectly associating the route table with the wrong subnet.
   - Misconfigured Network ACLs that block outbound traffic.

#### **Related Tips**:
- **Ensure Proper DNS Resolution**: If the instance still can’t connect to the internet, ensure that the VPC has DNS resolution enabled, and the EC2 instance is using valid DNS servers (check `/etc/resolv.conf`).
- **Public vs. Private Subnets**: Always confirm whether the EC2 instance is in a public or private subnet. Instances in private subnets require a NAT Gateway to access the internet.
- **VPC Peering**: If using VPC peering, ensure the route tables are updated to allow traffic between VPCs, and security group rules allow the necessary traffic.

### **Fix**:

Add the missing route to allow traffic to the Internet Gateway (fix the issue)
```
resource "aws_route" "internet_access_route" {
  route_table_id         = aws_route_table.main_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id
} 
```