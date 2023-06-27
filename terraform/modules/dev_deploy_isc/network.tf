resource "aws_vpc" "vpc_obligatorio" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name_vpc
  }
}



resource "aws_subnet" "pub_subnet1_obligatorio" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id 
  availability_zone       = var.vpc_aws_az
  cidr_block              = var.vpc_cidr1
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet obligatorio"
  }
}

resource "aws_subnet" "pub_subnet2_obligatorio" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id 
  availability_zone       = var.vpc_aws_az2
  cidr_block              = var.vpc_cidr2
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet2 obligatorio"
  }
}

resource "aws_internet_gateway" "web_lb_igw" {
  vpc_id = aws_vpc.vpc_obligatorio.id

  tags = {
    Name = "web-lb-igw"
  }
}


resource "aws_default_route_table" "oblig-route-table" {
  default_route_table_id = aws_vpc.vpc_obligatorio.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"  
    gateway_id = aws_internet_gateway.web_lb_igw.id
  }
  tags = {
    Name = "default route table"
  }
}

resource "aws_route" "web_lb_route" {
  route_table_id         = aws_vpc.vpc_obligatorio.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.web_lb_igw.id
}

resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.pub_subnet1_obligatorio.id, aws_subnet.pub_subnet2_obligatorio.id]  # Incluye las dos subredes en la misma AZ
  security_groups    = [aws_security_group.web_lb_sg.id]

  tags = {
    Name = "web-lb"
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {    
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_target_group.arn
        
      }    
}



resource "aws_lb_target_group" "web_target_group" {
  name     = "web-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc_obligatorio.id
}

resource "aws_lb_target_group_attachment" "web_attachment1" {
  target_group_arn = aws_lb_target_group.web_target_group.arn
  target_id        = aws_instance.module-web1-instance-deploy.id
  port             = 8080
  
}

resource "aws_lb_target_group_attachment" "web_attachment2" {
  target_group_arn = aws_lb_target_group.web_target_group.arn
  target_id        = aws_instance.module-web2-instance-deploy.id
  port             = 8080
}
