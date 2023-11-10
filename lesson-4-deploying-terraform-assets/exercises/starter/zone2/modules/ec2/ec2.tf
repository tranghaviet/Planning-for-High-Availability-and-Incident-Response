resource "aws_instance" "ubuntu" {
  ami           = var.aws_ami
  count = var.instance_count
  instance_type = "t3.micro"
  subnet_id = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  // insert SSH key for ec2 instance
  key_name = var.key_name

  tags = {
    Name = "Ubuntu-Web"
  }
}

resource "aws_security_group" "ec2_sg" {
  name       = "ec2_sg"
  vpc_id = var.vpc_id

  // allow inbound connection anywhere on port 80 and 22
  ingress {
    description = "web port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}
