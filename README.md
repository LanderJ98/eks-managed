# eks-managed
This repo creates a VPC alongside a fully managed EKS cluster.

Dependencies required for local provisioning:
* Terraform
* aws cli
* kubectl

## GitHub Actions

I am using AzureRM as the TF backend due to its state locking abilities but AWS as the Cloud provider to provision resources.

Configuring Azure Service principals
```shell
az ad sp create-for-rbac --name <name> --role contributor --scopes /subscriptions/<subscription>
```
It will return a password which in turn is also referenced as the CLIENT_SECRET. The rest of the details you can get from the Azure portal  
Create four repository secrets  
* CLIENT_ID = appId
* CLIENT_SECRET = Password
* TENANT_ID = tenantId
* SUBSCRIPTION_ID = subscriptionId

Configuring AWS OPENID Connect

Follow this guide to create the provider and role - https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/  

You will then need to create a trust relationship to look like the below.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::<account>:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:<username>/<repo-name>:*"
                },
                "ForAllValues:StringEquals": {
                    "token.actions.githubusercontent.com:iss": "https://token.actions.githubusercontent.com",
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
```

Create a repo secret called AWS_GITHUB_ROLE and the value being the ARN of the role you create earlier

## Terraform Docs

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.11.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.22.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 19.15.3 |
| <a name="module_external_dns_eks_role"></a> [external\_dns\_eks\_role](#module\_external\_dns\_eks\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |
| <a name="module_zone"></a> [zone](#module\_zone) | terraform-aws-modules/route53/aws//modules/zones | ~> 2.0 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role_binding_v1.full_access_crb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding_v1) | resource |
| [kubernetes_cluster_role_v1.full_access](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_v1) | resource |
| [kubernetes_config_map_v1.cert_manager_cm](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1) | resource |
| [kubernetes_config_map_v1.external_dns_cm](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1) | resource |
| [kubernetes_config_map_v1.ingress_nginx_cm](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1) | resource |
| [kubernetes_namespace_v1.cert_manager_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_namespace_v1.ingress_nginx_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | AWS account number | `string` | n/a | yes |
| <a name="input_cert_manager_namespace"></a> [cert\_manager\_namespace](#input\_cert\_manager\_namespace) | n/a | `string` | `"cert-manager"` | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | n/a | `string` | `"10.10.0.0/16"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster | `string` | `"test-cluster"` | no |
| <a name="input_cluster_role_name"></a> [cluster\_role\_name](#input\_cluster\_role\_name) | Kubernetes metadata cluster role name | `string` | `"full_access"` | no |
| <a name="input_crb_name"></a> [crb\_name](#input\_crb\_name) | Kubernetes metadata cluster role binding name | `string` | `"full_access_crb"` | no |
| <a name="input_default_instance_types"></a> [default\_instance\_types](#input\_default\_instance\_types) | The default instance types | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"test-lab"` | no |
| <a name="input_external_dns_namespace"></a> [external\_dns\_namespace](#input\_external\_dns\_namespace) | n/a | `string` | `"kube-system"` | no |
| <a name="input_external_dns_sa_name"></a> [external\_dns\_sa\_name](#input\_external\_dns\_sa\_name) | n/a | `string` | `"external-dns"` | no |
| <a name="input_github_repo_name"></a> [github\_repo\_name](#input\_github\_repo\_name) | n/a | `string` | `"eks-managed"` | no |
| <a name="input_install_cert_manager_crds"></a> [install\_cert\_manager\_crds](#input\_install\_cert\_manager\_crds) | n/a | `bool` | `true` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Override instance types | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_intra_subnets"></a> [intra\_subnets](#input\_intra\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.10.7.0/24",<br>  "10.10.8.0/24",<br>  "10.10.9.0/24"<br>]</pre> | no |
| <a name="input_nginx_namespace"></a> [nginx\_namespace](#input\_nginx\_namespace) | n/a | `string` | `"nginx"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.10.1.0/24",<br>  "10.10.2.0/24",<br>  "10.10.3.0/24"<br>]</pre> | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.10.4.0/24",<br>  "10.10.5.0/24",<br>  "10.10.6.0/24"<br>]</pre> | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | IAM role name | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name | `string` | `"cluster-vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | n/a |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_nameservers"></a> [nameservers](#output\_nameservers) | n/a |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | n/a |
<!-- END_TF_DOCS -->