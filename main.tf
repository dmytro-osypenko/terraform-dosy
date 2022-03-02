provider "aws"{
region = "us-east-1"
}

resource "aws_instance" "example" {
    ami = "ami-0e472ba40eb589f49"
    instance_type = "t2.micro"
    tags = {
        Name = "terraform-example"
    }
}
