resource "aws_instance" "module-web1-instance-deploy" {
    instance_type          = var.instance_type
    key_name               = var.key_name
    ami                    = var.ami
    vpc_security_group_ids = [aws_security_group.web-SG.id]
    subnet_id              = aws_subnet.pub_subnet1_obligatorio.id
    availability_zone      = var.vpc_aws_az
    user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y        
EOF
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("/Users/marcio/Documents/ORT/Cloud/labsuser.pem")
      host = self.public_ip
    }
    provisioner "remote-exec" {
      inline = [
        
        "sudo yum install -y git curl docker",
        "sudo curl -L \"https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
        "sudo chmod +x /usr/local/bin/docker-compose",
        "sudo usermod -aG docker ec2-user",
        "cd /home/ec2-user/",
        "sudo git clone https://github.com/mfontes1/ORT_obligatorio_isc_2023.git",      
        "sudo systemctl enable docker",
        "sudo systemctl start docker",
        "cd /home/ec2-user/ORT_obligatorio_isc_2023/terraform/modules/dev_deploy_isc/docker-compose/",      
        "docker-compose up -d"
        
                
  ]
}
tags = {
        Name = var.name_instance
    }
}
 
resource "aws_instance" "module-web2-instance-deploy" {
    instance_type          = var.instance_type
    key_name               = var.key_name
    ami                    = var.ami
    vpc_security_group_ids = [aws_security_group.web-SG.id]
    subnet_id              = aws_subnet.pub_subnet2_obligatorio.id 
    availability_zone      = var.vpc_aws_az2
    user_data     = <<-EOF
    #!/bin/bash
    sudo yum update -y
    
     
  EOF
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("/Users/marcio/Documents/ORT/Cloud/labsuser.pem")
      host = self.public_ip
    }
    provisioner "remote-exec" {
      inline = [
        "sudo yum install -y git curl docker",
        "sudo curl -L \"https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
        "sudo chmod +x /usr/local/bin/docker-compose",
        "sudo usermod -aG docker ec2-user",
        "cd /home/ec2-user/",
        "sudo git clone https://github.com/mfontes1/ORT_obligatorio_isc_2023.git",        
        "sudo systemctl enable docker",
        "sudo systemctl start docker", 
        #"cd home/ec2-user/ORT_obligatorio_isc_2023/terraform/modules/dev_deploy_isc/docker-compose/",     
        #"docker-compose up -d"
                
       ]
    }    
    tags = {
        Name = var.name_instance2
    }
}

resource "aws_instance" "module-cache-instance-deploy" {
    instance_type          = var.instance_type
    key_name               = var.key_name
    ami                    = var.ami
    vpc_security_group_ids = [aws_security_group.web-SG.id]
    subnet_id              = aws_subnet.pub_subnet1_obligatorio.id
    availability_zone      = var.vpc_aws_az
    user_data     = <<-EOF
    #!/bin/bash
    sudo yum update -y
           
  EOF

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("/Users/marcio/Documents/ORT/Cloud/labsuser.pem")
      host = self.public_ip
    }
    provisioner "remote-exec" {
    inline = [        
       "sudo yum install -y git curl docker",
        "sudo curl -L \"https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
        "sudo chmod +x /usr/local/bin/docker-compose",
        "sudo usermod -aG docker ec2-user",
        "cd /home/ec2-user/",
        "sudo git clone https://github.com/mfontes1/ORT_obligatorio_isc_2023.git",
        "sudo systemctl enable docker",
        "sudo systemctl start docker",
        #"cd ORT_obligatorio_isc_2023/terraform/modules/dev_deploy_isc/docker-compose/",      
        #"docker-compose up -d" 
              
  ]
}
tags = {
        Name = "Instancia Super-Cache"
    }
}

