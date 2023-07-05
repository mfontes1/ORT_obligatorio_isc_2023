resource "aws_security_group" "web-SG" {
  name   = var.sg_name
  vpc_id = aws_vpc.vpc_obligatorio.id 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terraform-ac1-sg"
  }
}

resource "aws_security_group" "web_lb_sg" {
  name   = "terraform-web-lb-sg"
  vpc_id = aws_vpc.vpc_obligatorio.id 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terraform-web-lb-sg"
  }
}

resource "aws_security_group" "efs-sg" {
  name        = "efs-security-group"
  description = "Security group for EFS access"
  vpc_id = aws_vpc.vpc_obligatorio.id 

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/16"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  
  }
}