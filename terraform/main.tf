terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = var.aws_region
}


data "aws_availability_zones" "available" {
  state = "available"
}


data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}


resource "aws_vpc" "shopedge_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name    = "shopedge-vpc"
    Project = "ShopEdge"
  }
}


resource "aws_internet_gateway" "shopedge_igw" {
  vpc_id = aws_vpc.shopedge_vpc.id
  tags = {
    Name    = "shopedge-igw"
    Project = "ShopEdge"
  }
}


resource "aws_route_table" "shopedge_public_rt" {
  vpc_id = aws_vpc.shopedge_vpc.id
  tags = {
    Name    = "shopedge-public-rt"
    Project = "ShopEdge"
  }
}


resource "aws_route" "shopedge_inet_route" {
  route_table_id         = aws_route_table.shopedge_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.shopedge_igw.id
}


resource "aws_subnet" "public_subnets" {
  for_each = {
    a = {
      cidr = var.public_subnet_cidrs[0]
      az   = data.aws_availability_zones.available.names[0]
    }
    b = {
      cidr = var.public_subnet_cidrs[1]
      az   = data.aws_availability_zones.available.names[1]
    }
  }
  vpc_id                  = aws_vpc.shopedge_vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = {
    Name    = "shopedge-public-${each.key}"
    Project = "ShopEdge"
    Tier    = "public"
  }
}