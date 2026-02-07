
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }
}

resource "aws_instance" "server" {
  for_each = toset(var.service_names)

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.terraform_sg.security_group_id] 
  associate_public_ip_address = true 

  tags = {
    Name = "alfonso-terraform-${each.key}"
  }

} 