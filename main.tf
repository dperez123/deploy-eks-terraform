provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
  region = var.region
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.16.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = 1.27
  subnet_ids      = [aws_subnet.subnet_cluster.id, aws_subnet.subnet_cluster2.id, aws_subnet.subnet_cluster3.id]
  vpc_id          = aws_vpc.vpc_cluster.id

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }
  eks_managed_node_groups = {
    one = {
      name           = "eks-node-group"
      instance_types = ["t2.micro"]
      desired_size   = 2
      min_size       = 2
      max_size       = 5
    }
  }
}
