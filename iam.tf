resource "aws_iam_openid_connect_provider" "terraform_cicd" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]

  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

resource "aws_iam_role" "terraform_cicd_oidc_role" {
  name = "TerraCICDDemoOIDCRole"
  path = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRoleWithWebIdentity"
      Principal = {
        Federated = aws_iam_openid_connect_provider.terraform_cicd.arn
      }
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = [
            "repo:so-stj/Tofu-aws:*",
          ]
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "AdministratorAccess_attachment" {
  role       = aws_iam_role.terraform_cicd_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
