#########################################################
# Define the template variables
#########################################################

variable "aws_s3_bucket_name" {
  description = "AWS S3 service unique name"
}

#########################################################

resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.aws_s3_bucket_name}"
  acl    = "public-read"
}
resource "aws_s3_bucket_policy" "b" {
  bucket = "${aws_s3_bucket.my_bucket.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "S3-allow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::${var.aws_s3_bucket_name}/*"
    }
  ]
}
POLICY
}
resource "aws_iam_user" "cosweb" {
  name = "${var.aws_s3_bucket_name}"
}
