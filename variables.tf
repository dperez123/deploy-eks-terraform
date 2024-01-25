variable "region" {
  default = "us-east-2"
}

variable "eks_cluster_name" {
  default = "eks-cluster"
}

variable "eks_node_group_instance_type" {
  default = "t2.micro"
}

variable "vpc_name" {
  default = "eks-vpc"
}

variable "vpc_cidr_block" {
  default = "192.168.0.0/16"
}