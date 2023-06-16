variable "ami" {
  description = "Ami ID"
  type = string
}

variable "instance_type" {
  description = "Tipo de Instancia"
  type = string
}

variable "key_name" {
    type = string
}

variable "name_instance" {
    type = string
}


variable "name_instance2" {
    type = string
}

variable "name_vpc" {
    type = string
  
}


variable "vpc_cidr" {
    type = string

}

variable "vpc_cidr1" {
    type = string

}

variable "vpc_cidr2" {
    type = string

}

variable "public_subnet1" {
    type = string

}

variable "public_subnet2" {
    type = string

}

variable "vpc_aws_az" {
    type = string

}

variable "vpc_aws_az2" {
    type = string

}

variable "sg_name" {
    type = string
  
}


output "dns" {
  value = aws_instance.module-web1-instance-deploy.public_dns
}


