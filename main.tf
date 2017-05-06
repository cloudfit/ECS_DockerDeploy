provider "aws" {
access_key = "${var.access_key}"
secret_key = "${var.secret_key}"
region = "us-east-1"
}

module "vpc" {
    source = "/opt/modules/mod_vpc"
    name = "ecs-vpc"
    cidr = "10.0.0.0/16"
    public_subnets  = "10.0.101.0/24,10.0.102.0/24"
    azs = "us-east-1c,us-east-1b"
}

/* Security group to allow SSH access */

resource "aws_security_group" "allow_ssh" {
name = "allow_ssh_sg"
description = "Allow inbound SSH traffic from my IP"
vpc_id = "${module.vpc.vpc_id}"
ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
tags {
Name = "Allow SSH"
}
}
