module "obligatorio-module" {
    source = "./modules/obligatorio-module"
    ami = var.ami_input
    instance_type = var.instance_type_input
    key_name    = var.key_name_input
    name_instance = var.instance_name_input
}

output "dns-output" {
    value = module.obligatorio-module.dns
}

 
