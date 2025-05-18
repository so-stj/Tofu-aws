data "aws_iam_policy_document" "example_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::533765226298:oidc-provider/token.actions.githubusercontent.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # 特定のリポジトリの特定のブランチからのみ認証を許可する
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:so-stj/Tofu-aws:ref*"]
    }
    # 特定のリポジトリの全てのワークフローから認証を許可する場合はこっち
    # condition {
    #   test     = "StringLike"
    #   variable = "token.actions.githubusercontent.com:sub"
    #   values   = ["repo:<GitHubユーザー名>/<GitHubリポジトリ名>:*"]
    # }
  }
}

resource "aws_iam_role" "example" {
  name               = "oidc-example-role"
  assume_role_policy = data.aws_iam_policy_document.example_assume_role_policy.json
}

# 任意のポリシーをアタッチする
# AmazonS3ReadOnlyAccess をアタッチする例
resource "aws_iam_role_policy_attachment" "example_s3_readonly" {
  role       = aws_iam_role.example.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}