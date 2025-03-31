## AWS Things

variable "env" {}
variable "aws-region" {}

## VPC

variable "vpc-cidr-block" {
    type = string
}  
variable "vpc-name" {}

##Public Subnet

variable "pub-subnet-name" {
 
}
variable "pub-subnet-count" {}
variable "pub-subnet-az" {
   type = list(string)
}
variable "pub-cidr-block" {
 type = list(string)
}

##Private Subnet

variable "pri-subnet-name" {
  
}
variable "pri-subnet-count" {}
variable "pri-subnet-az" {
  type = list(string)
}

variable "pri-cidr-block" {
  type = list(string)
}


##Eks 

variable "eks_role_name" {
  
}

variable "aws_eks_cluster" {
  
}

variable "eks_node_group_name" {
  
}


## ECS

variable "task_def_name" {
  
}
