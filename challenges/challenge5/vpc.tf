# Step 1: Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.challenge}-VPC"
  }
}

# Step 2: Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.challenge}-InternetGateway"
  }
}

# Step 3: Create a subnet within the VPC
resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.challenge}-Subnet"
  }
}

# Step 4: Create a route table but omit the route to the Internet Gateway (this will cause the EC2 instance to not have internet access)
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.challenge}-RouteTable"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "main_route_table_assoc" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}

# Step 5: Create a security group to allow SSH access to the EC2 instance
resource "aws_security_group" "main_sg" {
  vpc_id = aws_vpc.main_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.challenge}-SecurityGroup"
  }
}