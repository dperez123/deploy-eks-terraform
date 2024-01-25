# create a new vpc
resource "aws_vpc" "vpc_cluster" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = var.vpc_name
  }
}



# create a new internet gateway
resource "aws_internet_gateway" "igw_cluster" {
  vpc_id = aws_vpc.vpc_cluster.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}


# create a new route table
resource "aws_route_table" "route_table_cluster" {
  vpc_id = aws_vpc.vpc_cluster.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_cluster.id
  }
  tags = {
    Name = "${var.vpc_name}-route-table"
  }
}

# associate route table with subnet1
resource "aws_route_table_association" "route_table_association_cluster" {
    subnet_id = aws_subnet.subnet_cluster.id
  route_table_id = aws_route_table.route_table_cluster.id
}

# associate route table with subnet2
resource "aws_route_table_association" "route_table_association_cluster2" {
    subnet_id = aws_subnet.subnet_cluster2.id
  route_table_id = aws_route_table.route_table_cluster.id
}

# associate route table with subnet3
resource "aws_route_table_association" "route_table_association_cluster3" {
    subnet_id = aws_subnet.subnet_cluster3.id
  route_table_id = aws_route_table.route_table_cluster.id
}

# create a new subnet zone 1
resource "aws_subnet" "subnet_cluster" {
  vpc_id            = aws_vpc.vpc_cluster.id
  map_public_ip_on_launch = true
  cidr_block        = "192.168.22.0/24"
    availability_zone = "us-east-2a"
    tags = {
    Name = "${var.vpc_name}-subnet-cluster"
    }
}
# create a new subnet zone 2
resource "aws_subnet" "subnet_cluster2" {
  vpc_id            = aws_vpc.vpc_cluster.id
  map_public_ip_on_launch = true
  cidr_block        = "192.168.23.0/24"
    availability_zone = "us-east-2b"
    tags = {
    Name = "${var.vpc_name}-subnet-cluster2"
    }
}
# create a new subnet zone 3
resource "aws_subnet" "subnet_cluster3" {
  vpc_id            = aws_vpc.vpc_cluster.id
  map_public_ip_on_launch = true
  cidr_block        = "192.168.24.0/24"
    availability_zone = "us-east-2c"
    tags = {
    Name = "${var.vpc_name}-subnet-cluster3"
    }
}