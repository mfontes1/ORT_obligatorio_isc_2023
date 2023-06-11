resource "aws_instance" "module-web1-instance-deploy" {
    instance_type          = var.instance_type
    key_name               = var.key_name
    ami                    = var.ami
    vpc_security_group_ids = [aws_security_group.web-SG.id]
    subnet_id              = aws_subnet.pub_subnet1_obligatorio.id
    availability_zone      = var.vpc_aws_az
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("/Users/marcio/Documents/ORT/Cloud/vockey.pem")
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
        "sudo yum install -y httpd git curl",
        #"git clone https://github.com/mfontes1/ORT_obligatorio_isc_2023.git",
        #"sudo mv ORT_obligatorio_isc_2023/docs/img/maxresdefault.jpg /var/www/html/",
        "sudo systemctl enable httpd",
        "sudo systemctl start httpd",

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
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("/Users/marcio/Documents/ORT/Cloud/vockey.pem")
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
        #"sudo systemctl start nginx",
        #"sudo systemctl enable nginx",
        "sudo yum install -y httpd git curl",
        #"git clone https://github.com/mfontes1/ORT_obligatorio_isc_2023.git",
        #"sudo mv ORT_obligatorio_isc_2023/docs/img/maxresdefault.jpg /var/www/html/",
        "sudo systemctl enable httpd",
        "sudo systemctl start httpd",
       ]
    }    
    tags = {
        Name = var.name_instance2
    }
}