resource "aws_iam_role" "ec2-role" {
  name = "ec2-fole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "instance-role-profile" {
  name = "instance-role-policy"
  role = "${aws_iam_role.ec2-role.name}"
}

resource "aws_iam_role_policy" "ec2-policy" {
  name = "ec2-policy"
  role = "${aws_iam_role.ec2-role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::mills-storage"
      ]
    },

    {
      "Effect": "Allow",
      "Action": [
        "s3:ListAllMyBuckets",
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::*"
    }

  ]
}
EOF
}
