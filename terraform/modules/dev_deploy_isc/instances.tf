resource "aws_instance" "module-web1-instance-deploy" {
    instance_type          = var.instance_type
    key_name               = var.key_name
    ami                    = var.ami
    vpc_security_group_ids = [aws_security_group.web-SG.id]
    subnet_id              = aws_subnet.pub_subnet1_obligatorio.id
    availability_zone      = var.vpc_aws_az
    user_data     = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y git curl docker 
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo usermod -aG docker ec2-user"
    
  EOF      
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("/Users/marcio/Documents/ORT/Cloud/labsuser.pem")
      host = self.public_ip
    }
    provisioner "remote-exec" {
    inline = [
        
        #"sudo yum update",
        #"sudo yum install -y nginx git curl",
        #"sudo git clone https://github.com/mauricioamendola/chaos-monkey-app.git /tmp/chaos-monkey-app",
        #"sudo mv /usr/share/nginx/html /usr/share/nginx/html_backup",
        #"sudo cp -r /tmp/chaos-monkey-app /usr/share/nginx/html",
        #"sudo chown -R nginx:nginx /usr/share/nginx/html",    
        #"sudo chmod -R 755 /usr/share/nginx/html",
        #"sudo sed -i 's#root /usr/share/nginx/html;#root /usr/share/nginx/html; index index.html;#' /etc/nginx/nginx.conf",       
        #"sudo systemctl enable nginx",
        #"sudo systemctl start nginx",
        #"sudo yum install -y git docker curl",
        #"git clone https://github.com/mfontes1/ORT_obligatorio_isc_2023.git",
        #"sudo mv ORT_obligatorio_isc_2023/docs/img/maxresdefault.jpg /var/www/html/",
        #"sudo usermod -aG docker ec2-user",
        #"sudo amazon-linux-extras install -y nginx1",
        #"sudo yum update",
        #"cd ORT_obligatorio_isc_2023/terraform/modules/dev_deploy_isc/docker-compose",
        #"sudo yum update -y",
        #"sudo yum install -y docker",        
        #"mkdir /home/ec2-user/proyecto_isc",        
        #"sudo pip3 install docker-compose",
   
        "exit",
        "mkdir -p /home/ec2-user/proyecto",
        "cd /home/ec2-user/proyecto",
        "git clone https://github.com/mfontes1/ORT_obligatorio_isc_2023.git ",               
        "cd ORT_obligatorio_isc_2023/terraform/modules/dev_deploy_isc/docker-compose/",
        "sudo systemctl enable docker",
        "sudo systemctl start docker",
        "docker-compose up -d",           
        #"git clone https://github.com/mfontes1/ORT_obligatorio_isc_2023.git", 
        #"sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/sbin/docker-compose",
        #"sudo chmod +x /usr/local/sbin/docker-compose",

        #"cd ORT_obligatorio_isc_2023/terraform/modules/dev_deploy_isc/docker-compose",
        #"sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/sbin/docker-compose",
        #"sudo chmod +x /usr/local/sbin/docker-compose",
                
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
    yum update -y
    yum install -y git curl docker
     
  EOF
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("/Users/marcio/Documents/ORT/Cloud/labsuser.pem")
      host = self.public_ip
    }
    provisioner "remote-exec" {
      inline = [ 
       
        #"sudo pip3 install docker-compose",        
        "sudo systemctl enable docker",
        "sudo systemctl start docker",
        "mkdir proyecto_isc",
        #"cd proyecto_isc  | sudo git clone https://github.com/mfontes1/ORT_obligatorio_isc_2023.git",  
        #"cd ORT_obligatorio_isc_2023/terraform/modules/dev_deploy_isc/docker-compose",
        #"sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/sbin/docker-compose",
        #"sudo chmod +x /usr/local/sbin/docker-compose",
        
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
    yum update -y
    yum install -y git curl docker
       
  EOF

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("/Users/marcio/Documents/ORT/Cloud/labsuser.pem")
      host = self.public_ip
    }
    provisioner "remote-exec" {
    inline = [
        
        #"sudo yum update",
        #"sudo amazon-linux-extras install -y nginx1",
        #"sudo yum install -y  git curl",
        #"sudo git clone https://github.com/mauricioamendola/chaos-monkey-app.git /tmp/chaos-monkey-app",
        #"sudo mv /usr/share/nginx/html /usr/share/nginx/html_backup",
        #"sudo cp -r /tmp/chaos-monkey-app /usr/share/nginx/html",
        #"sudo chown -R nginx:nginx /usr/share/nginx/html",    
        #"sudo chmod -R 755 /usr/share/nginx/html",
        #"sudo sed -i 's#root /usr/share/nginx/html;#root /usr/share/nginx/html; index index.html;#' /etc/nginx/nginx.conf",       
        #"sudo systemctl enable nginx",
        #"sudo systemctl start nginx",
        #"sudo yum install -y git docker-ce",
        #"git clone https://github.com/mfontes1/ORT_obligatorio_isc_2023.git",
        #"sudo yum update -y",        
        #"sudo pip3 install docker-compose",        
        "sudo systemctl enable docker",
        "sudo systemctl start docker",
        "mkdir /home/ec2-user/proyecto_isc/",
        #"cd /home/ec2-user/proyecto_isc/ ", 
        #"git clone https: //github.com/mfontes1/ORT_obligatorio_isc_2023.git",       
        #"cd ORT_obligatorio_isc_2023/terraform/modules/dev_deploy_isc/docker-compose",
        #"sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/sbin/docker-compose",
        #"sudo chmod +x /usr/local/sbin/docker-compose",
        #"docker-compose -h",
  ]
}
tags = {
        Name = "Instancia Super-Cache"
    }
}

