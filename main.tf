provider "aws"{
region = "us-east-1"
}

resource "aws_instance" "example" {
    ami                    = "ami-0e472ba40eb589f49"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
    user_data = <<-EOF
 #!/bin/bash
 yum -y update
 yum -y install httpd
 myip =`curl http://169.254.169.254/latest/meta-data/local-ipv4`
 echo "<h2>My webserver at $myip<h2>" > /var/www/html/index.html
 sudo service httpd start
 chkconfig httpd on
 EOF
    tags = {
        Name = "terraform-example"
    }
}
resource "aws_security_group" "instance" {
    name = "terraform-example-instance"

    ingress {
        from_port        = 8080
        protocol         = "tcp"
        to_port          = 8080
        cidr_blocks      = ["0.0.0.0/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}
