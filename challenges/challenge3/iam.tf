# Create an IAM user
resource "aws_iam_user" "example_user" {
  name = "${var.challenge}-user"
}

resource "aws_iam_user_policy_attachment" "example_user_policy" {
  user       = aws_iam_user.example_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Create an access key for the IAM user
resource "aws_iam_access_key" "example_access_key" {
  user = aws_iam_user.example_user.name
}