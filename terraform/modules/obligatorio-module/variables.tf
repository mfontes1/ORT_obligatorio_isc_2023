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

output "dns" {
  value = aws_instance.module-web1-instance-deploy.public_dns
}

