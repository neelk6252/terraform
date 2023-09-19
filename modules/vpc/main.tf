resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name      = "main-vpc"
    createdby = "Cloud_clan"
    Terraform = "True"
  }
}

resource "aws_subnet" "public_subnet-1a" {
  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = var.public_subnet-1a
  map_public_ip_on_launch                     = var.dna-ip
  enable_resource_name_dns_a_record_on_launch = var.dna-ip
  availability_zone                           = var.availability-zone-1a

  tags = {
    Name      = "public_subnet-1a"
    createdby = "Cloud_clan"
    Terraform = "True"
  }
}
resource "aws_subnet" "public_subnet-1b" {
  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = var.public_subnet-1b
  map_public_ip_on_launch                     = var.dna-ip
  enable_resource_name_dns_a_record_on_launch = var.dna-ip
  availability_zone                           = var.availability-zone-1b

  tags = {
    Name      = "public_subnet-1b"
    createdby = "Cloud_clan"
    Terraform = "True"
  }
}

resource "aws_subnet" "private_subnet-1a" {
  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = var.private_subnet-1a
  map_public_ip_on_launch                     = "false"
  enable_resource_name_dns_a_record_on_launch = "false"
  availability_zone                           = var.availability-zone-1a
  tags = {
    Name      = "private_subnet-1a"
    createdby = "Cloud_clan"
    Terraform = "True"
  }
}
resource "aws_subnet" "private_subnet-1b" {
  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = var.private_subnet-1b
  map_public_ip_on_launch                     = "false"
  enable_resource_name_dns_a_record_on_launch = "false"
  availability_zone                           = var.availability-zone-1b
  tags = {
    Name      = "private_subnet-1b"
    createdby = "Cloud_clan"
    Terraform = "True"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Cloud_clan_main-igw"
    createdby = "Cloud_clan"
    Terraform = "True"
  }
}
resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_subnet-1a.id

  tags = {
    Name = "Cloud_clan_NAT"
    createdby = "Cloud_clan"
    Terraform = "True"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "route_table-public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  } 
  tags = {
    Name = "Cloud_clan_route_table-public"
    createdby = "Cloud_clan"
    Terraform = "True"
  }
}
resource "aws_route_table" "private_table-private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "Cloud_clan_route_table-private"
    createdby = "Cloud_clan"
    Terraform = "True"
  }
}

resource "aws_route_table_association" "public_routing_table1" {
  subnet_id      = aws_subnet.public_subnet-1a.id
  route_table_id = aws_route_table.route_table-public.id
}
resource "aws_route_table_association" "public_routing_table2" {
  subnet_id      = aws_subnet.public_subnet-1b.id
  route_table_id = aws_route_table.route_table-public.id
}
resource "aws_route_table_association" "private_routing_table1" {
  subnet_id      = aws_subnet.private_subnet-1a.id
  route_table_id = aws_route_table.private_table-private.id
}
resource "aws_route_table_association" "private_routing_table2" {
  subnet_id      = aws_subnet.private_subnet-1b.id
  route_table_id = aws_route_table.private_table-private.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = [aws_subnet.public_subnet-1a.id, aws_subnet.public_subnet-1b.id]
}

output "private_subnets" {
  value = [aws_subnet.private_subnet-1a.id, aws_subnet.private_subnet-1b.id]
}