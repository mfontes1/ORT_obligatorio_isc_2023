module "dev_deploy_isc" {
    source = "./modules/dev_deploy_isc"
    ami = var.ami_input
    instance_type = var.instance_type_input
    key_name    = var.key_name_input
    name_instance = var.name_instance_input
    name_instance2 = var.name_instance2_input
    name_vpc = var.name_vpc_input
    vpc_cidr = var.vpc_cidr_input
    vpc_cidr1 = var.vpc_cidr1_input
    vpc_cidr2 = var.vpc_cidr2_input
    public_subnet1 = var.public_subnet1_input
    public_subnet2 = var.public_subnet2_input
    vpc_aws_az = var.availability_zone
    vpc_aws_az2 = var.availability_zone2
    sg_name = var.sg_name_input
 
    
}



output "dns-output" {
    value = module.dev_deploy_isc
}

 
