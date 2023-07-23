# aws-terraform-devops-upskilling-3pg
- AWS in 3 tiers deployed using Terraform.

# Configuración
- Configuration variables
  
```
export AWS_ACCESS_KEY_ID="TU_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="TU_SECRET_KEY"
```

# How to create the infrastructure.
```
terraform init
terraform plan 
terraform apply
```

# How to destroy the infrastructure.
```
terraform destroy
```

# Expected Infrastructure
![](./img/infra.png)

# How to connect to an EC2 instance
```
chmod 400 generated_key.pem
ssh -i generated_key.pem ubuntu@<EC2_INSTANCE_PUBLIC_IP>
```
If the key is not present, you must create it on the nested instances.

# Definition of the layers

# Presentation layer
This is the topmost level of the application, responsible for gathering information. It provides a user interface and handles user interactions, sending content to browsers in the form of HTML/JS/CSS and communicates with other layers to provide results to the browser/client-side.

# Logic layer
Also known as the application layer. It contains a set of rules for processing information, business logic, and can accommodate many users. It is sometimes also referred to as middleware. It 

# Data layer
A database, comprising both datasets and the database management system or RDBMS software that manages and provides access to the data (back-end). It provides data security, integrity, and support to the application.

# Application 
https://github.com/JamesonC/CRUD-react-express-node-postgresql

# References
https://aws.plainenglish.io/3-tier-architecture-in-aws-e410d610ed74
https://github.com/AWS-Devops-Projects/Terraform-3tier-architecture-AWS
