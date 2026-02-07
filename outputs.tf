output "ip_privada_server" {
    description = "la IP privada de la EC2"
    value = {
    for k, inst in aws_instance.server : 
    k => {
        name = k
        private_ip = inst.private_ip
        public_ip = inst.public_ip
          }
        }
    }

    output "my_ip" {
  value = local.my_ip_cidr
}