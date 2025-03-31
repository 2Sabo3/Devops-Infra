resource "aws_eks_cluster" "eks" {
 name = var.aws_eks_cluster
 role_arn = aws_iam_role.eks-cluster.arn
 vpc_config {
   subnet_ids = [aws_subnet.privatesubnet[0].id,aws_subnet.privatesubnet[1].id]
 }
  
}

output "eks-endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks-kubeconfig-certificate" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}
