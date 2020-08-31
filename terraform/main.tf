provider "aws" {
  access_key = "<Enter your access key here>"
  secret_key = "<Enter your secret key here>"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.tracer.id]
  key_name = aws_key_pair.Ajaytestdemo.key_name

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "file" {
    source      = "tracer.py"
    destination = "/tmp/tracer.py"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("mykey")
  }
}

resource "aws_key_pair" "Ajaytestdemo" {
    key_name = "Ajaytestdemo"
    public_key = file("mykey.pub")
}

resource "aws_security_group" "tracer" {
    name = "tracer"
    description = "Allows HTTP and SSH connections."

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["Enter your public IP here"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["Enter your public IP here"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}