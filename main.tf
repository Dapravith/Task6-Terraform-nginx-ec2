data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "developer_portfolio_key" {
  key_name   = var.key_name
  public_key = file(pathexpand(var.public_key_path))
}

resource "aws_security_group" "web_server_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    description = "Web (8085)"
    from_port   = 8085
    to_port     = 8085
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "developer_portfolio_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.developer_portfolio_key.key_name
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }

  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  user_data = templatefile("${path.module}/user_data.sh", {
    github_repo_url = var.github_repo_url
  })

  tags = {
    Name = "${var.project_name}-server"
  }
}

output "instance_public_ip" {
  value = aws_instance.developer_portfolio_server.public_ip
}