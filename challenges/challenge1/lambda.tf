resource "aws_lambda_function" "data_process" {
  function_name = "data_process_test"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30

  filename      = "lambda_function.zip"
  depends_on = [null_resource.zip_lambda]
}

resource "null_resource" "zip_lambda" {
  provisioner "local-exec" {
    command = "zip lambda_function.zip lambda_function.py"
  }

  triggers = {
    "lambda_code_hash" = filemd5("lambda_function.py")
  }

  depends_on = [aws_iam_role.lambda_role]
}

resource "aws_lambda_permission" "allow_invocation" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.data_process.function_name
  principal     = "apigateway.amazonaws.com"
}