# se definieron las variables
variable "region" {
  type = string
  description = "Variable para la region"
}

variable "profile" {
  type = string
  description = "Variable para profile"
  
}

variable "ami_input" {
  type = string
  description = "variable para AMI"
  
}

variable "instance_type_input" {
  type = string
  description = "variable tipo de instancia "
  
}

variable "key_name_input" {
  type = string
  description = "variable de key_name"
  
}

variable "name_instance_input" {
  type = string
  description = "variable instanse_name"

}

variable "name_instance2_input" {
  type = string
  description = "variable instanse_name 2"

}

variable "name_vpc_input" {
  type = string
  description = "variable vpc name"
}

variable "vpc_cidr_input" {
  type = string
  description = "variable vpc cidir block"
  
}

variable "vpc_cidr1_input" {
  type = string
  description = "variable vpc cidir block"
  
}

variable "vpc_cidr2_input" {
  type = string
  description = "variable vpc cidir block 2"
  
}

variable "public_subnet1_input" {
    type = string

}

variable "public_subnet2_input" {
    type = string
}

variable "availability_zone" {
    type = string
  
}

variable "availability_zone2" {
    type = string
  
}

variable "sg_name_input" {
    type = string
  
}


