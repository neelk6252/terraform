resource "aws_security_group" "alb_sg" {
  name_prefix = "Transbnk_SG"
  vpc_id =var.vpcid
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access from anywhere"
  }
  
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP access from anywhere"
  }
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPs access from anywhere"
  }
  
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

output "ALB_Transbnk_sg" {
    value = aws_security_group.alb_sg.id
}