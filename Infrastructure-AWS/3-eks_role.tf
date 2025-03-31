resource "aws_iam_role" "eks-cluster" {
    name = var.eks_role_name
    assume_role_policy = data.aws_iam_policy_document.policy.json
}

data "aws_iam_policy_document" "policy" {
 statement {
   effect = "Allow"

   principals {
     type = "Service"
     identifiers = [ "eks.amazonaws.com" ]
   }

   actions = [ "sts:AssumeRole" ]
 }
  
}

resource "aws_iam_role_policy_attachment" "policy-attachment" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.eks-cluster.name
  
}

resource "aws_iam_role_policy_attachment" "policy_attach" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    role = aws_iam_role.eks-cluster.name
}
