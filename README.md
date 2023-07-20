# aws-3tier-umg-is-2023
- AWS in 3 capas desplegado en terraform.

# Configuración
- variables de configuración 

```
export AWS_ACCESS_KEY_ID="TU_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="TU_SECRET_KEY"
```

# Como crear la infraestructura.
```
terraform init
terraform plan 
terraform apply
```

# Como destruir la infraestructura.
```
terraform destroy
```

# Infrastructura esperada
![](./img/infra.png)

# Como conectarse a una ec2
```
chmod 400 generated_key.pem
ssh -i generated_key.pem ubuntu@<EC2_INSTANCE_PUBLIC_IP>
```
Si no esta la llave presente la debes de crear en las instancias anidadas.

# Definición de las capas
## Capa de presentación
- Este es el nivel más alto de la aplicación, responsable de recolectar la información. Proporciona una interfaz de usuario y maneja la interacción con el usuario, envía contenido a los navegadores en forma de HTML/JS/CSS y se comunica con otras capas para proporcionar los resultados al navegador/lado del cliente.

## Capa de lógica
- También conocida como la capa de aplicación. Contiene un conjunto de reglas para procesar información, lógica empresarial y puede acomodar a muchos usuarios. A veces también se le llama middleware. Procesa las entradas recibidas de los clientes e interactúa con la base de datos y se ejecuta en un servidor web.

## Capa de datos
- Una base de datos, que comprende tanto conjuntos de datos como el software de sistema de gestión de bases de datos o RDBMS que gestiona y proporciona acceso a los datos (back-end). Proporciona seguridad, integridad de datos y soporte a la aplicación.


# Application 

https://github.com/JamesonC/CRUD-react-express-node-postgresql


# References
https://aws.plainenglish.io/3-tier-architecture-in-aws-e410d610ed74
https://github.com/AWS-Devops-Projects/Terraform-3tier-architecture-AWS
