# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.12.13"
  backend "s3" {
    bucket         = "ankisatte"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    #dynamodb_table = "aws-locks"
    encrypt        = true
  }
}

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = "us-west-2"
  version = "~> 2.36.0"
}


# Commented out until after bootstrap

# Call the seed_module to build our ADO seed info
module "bootstrap" {
  source                      = "./modules/bootstrap"
  name_of_s3_bucket           = "ankisatte"
  dynamo_db_table_name        = "aws-locks"
  iam_user_name               = "GitHubActionsIamUser"
  ado_iam_role_name           = "GitHubActionsIamRole"
  aws_iam_policy_permits_name = "GitHubActionsIamPolicyPermits"
  aws_iam_policy_assume_name  = "GitHubActionsIamPolicyAssume"
}




# Build the VPC
resource "aws_vpc" "myvpc" {
    cidr_block = var.VPC

    tags = {
        Name = "aaaavpc"
    }
}

resource "aws_subnet" "public" {
    count = length(var.public_subnets_cidr)
    cidr_block = element(var.public_subnets_cidr,count.index)

    vpc_id = aws_vpc.myvpc.id
    availability_zone = element(var.azs,count.index)


    tags = {
        "Name" = "${var.stack}-subnet-${count.index +1}"
    }
  
}


#privatesubnets


resource "aws_subnet" "private" {
    count = length(var.private_subnets_cidr)
    cidr_block = element(var.private_subnets_cidr,count.index)

    vpc_id = aws_vpc.myvpc.id
    availability_zone = element(var.azs,count.index)


    tags = {
        "Name" = "${var.stack}-privatesubnet-${count.index +1}"
    }
  
}

#IGW

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id

    tags = {
        "Name" = "${var.stack}-IGW"
    }
  
}

#public_routetable
resource "aws_route_table" "publicrt" {
    vpc_id = aws_vpc.myvpc.id

     route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        "Name" = "${var.stack}-public rt-tf"
    }
}





#public_rt_subnets_assosiation
resource "aws_route_table_association" "subnet1assoc" {
    count = length(var.public_subnets_cidr)
    subnet_id       = element(aws_subnet.public.*.id, count.index)
    route_table_id  = aws_route_table.publicrt.id
  
}


#  nat gateway

#  nat gateway

resource "aws_nat_gateway" "nat" {
  subnet_id     = element(aws_subnet.private.*.id, count.index)
  allocation_id = aws_eip.eip.id

  tags = {
    Name = "${var.stack}-nat_gateway"
  }
}


resource "aws_eip" "eip" {

  vpc = true

  tags = {
    Name = "${var.stack}-nat-ip"
  }
}


#private _route_tables

resource "aws_route_table" "privatecrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.stack}-private"
  }
}


#private_rt_subnets_assosiation
resource "aws_route_table_association" "privatesubnet1assoc" {
    count = "${length(var.private_subnets_cidr)}"
    subnet_id       = "${element(aws_subnet.private.*.id, count.index)}"
    route_table_id  = "${aws_route_table.privatecrt.id}"
  
}



resource "aws_security_group" "my_sg" {
    name            = "${var.stack}-"
    description     = "${var.stack}-security group "
    vpc_id          = aws_vpc.myvpc.id
     ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["157.44.73.63/32"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        cidr_blocks = ["0.0.0.0/0"]
        protocol    = "-1"
        from_port   = "0"
        to_port     = "0"
    }
    tags = {
        Name = "${var.stack}-security_group"
    }
}



