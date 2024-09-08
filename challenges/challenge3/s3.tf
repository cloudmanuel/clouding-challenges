# Random numeric ID generator for the bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 3 # Generates a 5-character alphanumeric string
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

# Upload a sample object to the S3 bucket with ACL settings
resource "aws_s3_object" "sample_object" {
  bucket = aws_s3_bucket.example_bucket.bucket
  key    = "./files/sample.txt"
  source = "./files/sample.txt" # Make sure you have a file named 'sample.txt' in the same directory as your Terraform configuration
  acl    = "private" # default setting
}

# Create an S3 bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = "bucket-${var.challenge}-${random_id.bucket_suffix.hex}"
}

# bucket policy
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.example_bucket.id
  policy = data.aws_iam_policy_document.allow_access_to_user.json
}

data "aws_iam_policy_document" "allow_access_to_user" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.example_bucket.arn}/*",
    ]
  }
  statement {
    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_user.example_user.arn}"]
    }

    effect = "Deny"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.example_bucket.arn}/*",
    ]
  }
}