resource "aws_iam_role" "ec2_role_for_ssm" {
  name = "Transbnk-role-for-ssm"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach SSM policies to IAM Role
resource "aws_iam_role_policy_attachment" "ssm_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  role       = aws_iam_role.ec2_role_for_ssm.name
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ec2_role_for_ssm.name
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "Transbnk-instance-profile"

  # Add a depends_on parameter to ensure that the IAM role is created before the instance profile
  depends_on = [
    aws_iam_role.ec2_role_for_ssm,
    aws_iam_role_policy_attachment.ssm_full_access,
    aws_iam_role_policy_attachment.ssm_managed_instance_core,
  ]
  role = aws_iam_role.ec2_role_for_ssm.name


}

output "ssm_role_arn" {
  value = aws_iam_instance_profile.ec2_instance_profile.name
}