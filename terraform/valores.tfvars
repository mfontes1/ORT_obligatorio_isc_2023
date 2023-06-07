region = "us-east-1"
profile = "default"
instance_type_input = "t2.micro"
ami_input = "ami-0715c1897453cabd1"
key_name_input = "vockey"
name_instance_input = "Servidor-web-parametrizado"
name_vpc_input = "VPC_OBLIGATORIO_ISC"
vpc_cidr_input = "10.0.0.0/16"
vpc_cidr1_input = "10.0.1.0/24"
vpc_cidr2_input = "10.0.2.0/24"
public_subnet1_input = "true"
public_subnet2_input = "true"
availability_zone = "us-east-1a"
availability_zone2 = "us-east-1b"
sg_name_input = "SG_Obl_ssh_http"
#security_groups_input = [aws_security_group.web_lb_sg.id]








