resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "aws_key_pair" "generated_key" {
  key_name   = "generated_key"
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.this.private_key_pem
  filename = "${path.module}/generated_key.pem"
}

# How to connect
# chmod 400 generated_key.pem
# ssh -i generated_key.pem ubuntu@<EC2_INSTANCE_PUBLIC_IP>

