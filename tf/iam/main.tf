# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}

resource "aws_iam_access_key" "opa" {
  user    = "${aws_iam_user.opa.name}"
}

resource "aws_iam_user" "opa" {
  name = "datahub_opa_iam_user"
}

resource "aws_iam_user_policy" "opa_ro" {
  name = "test"
  user = "${aws_iam_user.opa.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::mimiro-*/*"
    }
  ]
}
EOF
}

output "opa_iam_user_secret" {
  sensitive = true
  value = "${aws_iam_access_key.opa.secret}"
}

output "opa_iam_user_access_key" {
  sensitive = true
  value = "${aws_iam_access_key.opa.id}"
}
