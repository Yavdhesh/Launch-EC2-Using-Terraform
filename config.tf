provider "aws" {

access_key = "ASIA4WFV7BJZC2BANNS7"

secret_key = "K3hZnXl9s16fVFLntkrQhv1/gaV36wyv95SF7Ele"

token= "FwoGZXIvYXdzEC4aDL2WZQzoJUtYq5pr6iLDAT3aEC1nX44WOH+d+5pdCn7WitgdC3NunvoZ7UwF0TSppLgDVign5DqScLWbJQoUkMUlhQVKUkBA50qqDPNS4NqrXRs14DMO4eBOHnVyhD9f6yd1bqHh8ozzTzrDs/7h2fE0lP8+alcqrZwIBIHUDD+Ma8rS4iuFO92GalSMgmQJaakDsPOriBpbTqvud+0M/MrgPpb95RAy02PzG8ZHZQqekumtqacY3TaHqhIIa02bF6/CEXsjEiqGoYzxYZdOF63TQCjGrJyJBjItzRlj8POOQRf+dOv7PQXFbSmTWwCB2m7zh7jnfhqnFONTG1ckmG0Gbrudr+/m"

region = "us-east-1"

}

data "aws_ami" "ubuntu" {

  most_recent = true



  filter {

    name   = "name"

    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]

  }



  filter {

    name   = "virtualization-type"

    values = ["hvm"]

  }



  owners = ["099720109477"] # Canonical

}

resource "aws_instance" "instance1" {

ami = data.aws_ami.ubuntu.id

instance_type = "t2.micro"

tags = {

Name = "Centos-8-Stream"

}

}

output "my-public-ip"{

       value= aws_instance.instance1.public_ip

}




















