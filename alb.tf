module "lb_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "eks_lb"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    main = {
      provider_arn               = "arn:aws:iam::381491903855:oidc-provider/example.oidcprovider.com"
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
  depends_on = [
    aws_eks_cluster.eks,                                                                                                                            
    aws_eks_node_group.nodes_general
  ]
}
