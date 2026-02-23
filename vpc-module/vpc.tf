resource "aws_vpc" "custom_vpc" {
  cidr_block = local.vpc_cidr

  tags = {
    Name = "project-x-${var.environment}-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = local.pub_subnet1_cidr
  availability_zone       = local.subnet1_zone
  map_public_ip_on_launch = true
  tags = {
    Name = local.pub_subnet1_tag
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = local.pub_subnet2_cidr
  availability_zone       = local.subnet2_zone
  map_public_ip_on_launch = true
  tags = {
    Name = local.pub_subnet2_tag
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = local.pub_subnet3_cidr
  availability_zone       = local.subnet3_zone
  map_public_ip_on_launch = true
  tags = {
    Name = local.pub_subnet3_tag
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = local.priv_subnet1_cidr
  availability_zone       = local.subnet1_zone
  map_public_ip_on_launch = false
  tags = {
    Name = local.priv_subnet1_tag
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = local.priv_subnet2_cidr
  availability_zone       = local.subnet2_zone
  map_public_ip_on_launch = false
  tags = {
    Name = local.priv_subnet2_tag
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = local.priv_subnet3_cidr
  availability_zone       = local.subnet3_zone
  map_public_ip_on_launch = false
  tags = {
    Name = local.priv_subnet3_tag
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = local.igw_tag
  }
}

resource "aws_route_table" "pub_default_route" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = local.pub_rt_tag
  }
}

resource "aws_route_table" "priv_default_route" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = local.priv_rt_tag
  }
}

resource "aws_route_table_association" "pub_a" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.pub_default_route.id
}
resource "aws_route_table_association" "pub_b" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.pub_default_route.id
}
resource "aws_route_table_association" "pub_c" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.pub_default_route.id
}

resource "aws_route_table_association" "priv_a" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.priv_default_route.id
}

resource "aws_route_table_association" "priv_b" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.priv_default_route.id
}

resource "aws_route_table_association" "priv_c" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.priv_default_route.id
}
