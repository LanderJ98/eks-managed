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

<!-- END_TF_DOCS -->