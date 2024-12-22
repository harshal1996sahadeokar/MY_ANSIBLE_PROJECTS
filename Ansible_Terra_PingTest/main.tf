provider "aws" {
  region = var.aws_region
}




# Security Group for SSH
resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"
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
}

# Ansible Controller EC2 Instance
resource "aws_instance" "ansible_controller" {
  ami           = "ami-053b12d3152c0cc71" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  key_name      = "ANSIBLE"
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "Ansible-Controller"
  }

  # Install Ansible using Remote Exec
  provisioner "remote-exec" {
    inline = [
      "sudo apt-add-repository ppa:ansible/ansible",
      "sudo apt update -y",
      "sudo apt install ansible -y"
    ]
    #connection {
      #type        = "ssh"
      #user        = "ubuntu"
      ##private_key = file(var.ssh_private_key_path)
      #host        = self.public_ip
    #}
  }
}

# Target EC2 Instance 1
resource "aws_instance" "target_1" {
  ami           = "ami-053b12d3152c0cc71" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  key_name      = "ANSIBLE"
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "Target-1"
  }
}

# Target EC2 Instance 2
resource "aws_instance" "target_2" {
  ami           = "ami-053b12d3152c0cc71" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  key_name      = "ANSIBLE"
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "Target-2"
  }
}
