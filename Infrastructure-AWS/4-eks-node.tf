resource "aws_eks_node_group"  "node-group" {
  node_group_name = var.eks_node_group_name
  cluster_name    = aws_eks_cluster.eks.name
  node_role_arn = aws_iam_role.eks-cluster.arn
  subnet_ids = [ aws_subnet.privatesubnet[0].id , aws_subnet.privatesubnet[1].id ]
  scaling_config {
    desired_size = 1
    max_size = 2
    min_size = 1

  }

  update_config {
    max_unavailable = 1
  }

  ami_type = "ami-066784287e358dad1"
  instance_types = [ "t2.micro" ]
  disk_size = 20
  capacity_type = "ON_DEMAND"
}

