provider "aws" {

access_key = "access-key-simplilearn"

secret_key = "secret-key-simplilearn"

token= "FwoGZXIvYXdzEDsaDFC9fhldwHZk4rhjJCLDASMvG7v8o5NS9Y3B5J5rxXVgTuk7JdCZq7T4sfzwZXh56VRD4RcloZfyg1curimpd6oJ0qc2FYcowxZ4BVvE3UgTKrwCQg0iuSgkstlrrU2Kj8L0AlR0FNERQD1SwW2IWW/rFJjjoOMyewwRvh/Tu4gpCa972oJyODO4Z0yZRqoVtRSnn3400y2Efn9GbTa6V+xLh8jtacJkUhyAySzSB/2DCkUeh6XmnrGDsRgH1yzoWKlCsULs3sYqh1M+eTWkQfyo7CjEq5+JBjIttTswFyD76AlhNG6nS8OUV6alz0HE5Qt11Vo2zKh961NniRr/OsE8e0xKHoWp"

region = "us-east-1"

}

resource "aws_security_group" "webserver_sg" {

  name        = "Ports 22-80"

  description = "Ports 22-80"



  ingress {

    from_port   = 22

    to_port     = 22

    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }



  egress {

    from_port   = 0

    to_port     = 0

    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }



  ingress {

    from_port   = 80

    to_port     = 80

    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }



  egress {

    from_port   = 0

    to_port     = 0

    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

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

key_name="aws_key"

vpc_security_group_ids = ["${aws_security_group.webserver_sg.id}"]


tags = {

Name = "Ubuntu-installation"

}

provisioner "remote-exec" {

    inline = [

      "sudo apt update -y",

      "sudo apt install openjdk-8-jdk -y",
    
      "sudo apt update -y",
       
      "sudo apt-get install python -y",

      "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",

      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",

      "sudo apt update -y ",

      "sudo apt install jenkins -y",

      "sudo systemctl status jenkins --no-pager",

      "sudo ufw allow 8080",
      
      "sudo ufw status",
      
      "sudo systemctl start jenkins --no-pager",
      
      "exit"


    ]



    connection {

      host        = self.public_ip

      type        = "ssh"

      user        = "ubuntu"

      private_key = file("/home/yogeshyogeshsan/Launch-aws/project-ec2-launch/aws_key.pem")

    }

  }

}

output "my-public-ip"{

       value= aws_instance.instance1.public_ip

}




















