# Terraform AWS Secure SSH VPC

## 1. Visión general

Este proyecto demuestra cómo aprovisionar una infraestructura segura en AWS utilizando Terraform, centrándose en fundamentos de red y en el endurecimiento del acceso por SSH.

El objetivo principal es desplegar instancias EC2, en este caso serán 3 dentro de una VPC personalizada, restringiendo dinámicamente el acceso SSH a la IP pública actual del usuario.

Este proyecto está diseñado como práctica técnica y de portfolio.

## 2. Arquitectura

La infraestructura creada por este proyecto incluye:

- Una VPC personalizada (CIDR: 10.0.0.0/16)
- Dos subredes públicas distribuidas en diferentes Availability Zones (azs)
- Internet Gateway para acceso a internet
- Security Group con:
  - Acceso SSH restringido a la IP pública del usuario (/32)
  - Acceso HTTPS habilitado
- Instancia EC2 desplegada dentro de la VPC

## 3. Tecnologías utilizadas

Para este proyecto he utilizado Terraform para el despliegue, y luego he contado con:

- AWS EC2  
- AWS VPC  
- AWS Security Groups  

## 4. Requisitos previos

Antes de desplegar el proyecto, asegúrate de tener:

- Una cuenta activa en AWS, usuario IAM generado, con permisos y unas keys  
- AWS CLI instalado y configurado  

Una vez instalado:

```bash
aws configure
E introduciremos las keys.

Terraform instalado

Conocimientos básicos de Linux, redes y AWS

5. Estructura del proyecto
text
Copiar código
main.tf → Definición principal de infraestructura
networking.tf → VPC, subredes y security groups
providers.tf → Configuración de Terraform y AWS
variables.tf → Variables de entrada
outputs.tf → Salidas (ip pública usuario, ips servidor)
locals.tf → Valores locales (IP pública dinámica de usuario)
.gitignore → Archivos ignorados por Git
README.md
Cada archivo tiene una única responsabilidad, siguiendo así una buena práctica.

6. Configuración
Restricción dinámica de IP para SSH
La IP pública del usuario se obtiene automáticamente mediante una fuente de datos HTTP externa:

Se consulta la IP desde https://api.ipify.org

Se convierte en un bloque CIDR /32

Y por último se inyecta directamente en las reglas del Security Group

Esto garantiza que el acceso SSH esté siempre limitado a la ubicación actual, sin cambios manuales.

7. Cómo usarlo
Clonar el repositorio
bash
Copiar código
git clone <url-del-repositorio>
cd terraform-aws-secure-ssh
Inicializar Terraform
bash
Copiar código
terraform init
Revisar el plan
bash
Copiar código
terraform plan
Aplicar la infraestructura
bash
Copiar código
terraform apply
Confirmar cuando lo solicite con:

bash
Copiar código
yes
Tras el despliegue:

Verifica que la VPC y subredes existen

Comprueba que el security group solo permite SSH desde tu IP

Para conectarte:

bash
Copiar código
ssh -i tu-clave.pem ubuntu@<ip-publica>
Si tu IP cambia, basta con ejecutar de nuevo:

bash
Copiar código
terraform apply
Y se actualizará automáticamente.

En caso de querer eliminar la infraestructura:

bash
Copiar código
terraform destroy
8. Consideraciones de seguridad
SSH limitado a una única IP (/32)

No se almacenan credenciales en el repositorio

Principio de mínimo privilegio en reglas de red

Infraestructura reproducible y auditable

Autor
Alfonso
Estudiante de ASIR | DevOps Junior