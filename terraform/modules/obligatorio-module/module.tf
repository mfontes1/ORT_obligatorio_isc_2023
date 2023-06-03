resource "aws_instance" "module-web1-instance-deploy" {
    instance_type = var.instance_type
    key_name = var.key_name
    ami = var.ami
    tags = {
        Name = var.name_instance
    }
}

resource "aws_instance" "module-web2-instance-deploy" {
    instance_type = var.instance_type
    key_name = var.key_name
    ami = var.ami
    tags = {
        Name = var.name_instance
    }
}