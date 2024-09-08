output "access_key" {
  value = aws_iam_access_key.example_access_key.id
}

output "secret_key" {
  value = aws_iam_access_key.example_access_key.secret
  sensitive = true
}