resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr-block
  tags = {
    name = "${var.vpc-name}"
    env = "${var.env}"
  }
}

resource "aws_subnet" "publicsubnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.pub-cidr-block, count.index)
  availability_zone = element(var.pub-subnet-az, count.index)
  #cidr_block = var.pub-cidr-block
  #availability_zone = var.pub-subnet-az
  map_public_ip_on_launch = true
  count = var.pub-subnet-count
  tags = {
    name = "${var.pub-subnet-name}-${count.index}"
    env  = "${var.env}"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

resource "aws_subnet" "privatesubnet" {
  vpc_id = aws_vpc.vpc.id
  count = var.pri-subnet-count
  cidr_block = element(var.pri-cidr-block, count.index)
  availability_zone = element(var.pri-subnet-az, count.index)
  #cidr_block = var.pri-cidr-block
  #availability_zone = var.pri-subnet-az
  tags = {
    name = "${var.pri-subnet-name}-${count.index}"
    env  = "${var.env}"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

