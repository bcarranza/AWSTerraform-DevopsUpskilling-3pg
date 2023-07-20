# Cuando una instancia EC2 en una subred privada necesita acceder a Internet,
# el flujo de tráfico sigue un camino específico a través del NAT Gateway y la
# subred pública. Aquí se explica el proceso:
#
# 1. Solicitud desde la instancia EC2: La instancia EC2 en la subred privada
# envía una solicitud para acceder a un recurso en Internet. Esta solicitud
# incluye la dirección IP privada de la instancia como la dirección IP de origen.
#
# 2. Enrutamiento a través de la tabla de rutas privada: La solicitud se dirige
# a la tabla de rutas asociada con la subred privada. Esta tabla de rutas tiene
# una regla que enruta el tráfico con destino a Internet (0.0.0.0/0) hacia el NAT
# Gateway.
#
# 3. Traducción de direcciones en el NAT Gateway: Cuando la solicitud llega al
# NAT Gateway en la subred pública, el NAT Gateway traduce la dirección IP privada
# de origen de la instancia EC2 a su propia dirección IP pública (la dirección IP
# del NAT Gateway). Este proceso se llama traducción de direcciones de origen (SNAT).
#
# 4. Solicitud a Internet: La solicitud, ahora con la dirección IP pública del NAT
# Gateway como la dirección IP de origen, se envía a Internet a través del Internet
# Gateway asociado con la VPC.
#
# 5. Respuesta desde Internet: Cuando el recurso de Internet envía una respuesta,
# la dirección IP de destino de la respuesta es la dirección IP pública del NAT
# Gateway.
#
# 6. Traducción inversa de direcciones en el NAT Gateway: El NAT Gateway traduce
# la dirección IP de destino en la respuesta de su propia dirección IP pública a
# la dirección IP privada original de la instancia EC2 que envió la solicitud. Este
# proceso se llama traducción inversa de direcciones (DNAT).
#
# 7. Entrega de la respuesta a la instancia EC2: La respuesta se envía de vuelta a
# través de la tabla de rutas privada y se entrega a la instancia EC2 en la subred
# privada utilizando su dirección IP privada.


# El nat gateway solo puede ser uno, por lo que debemos colocar solo en una subnet 
# publica.
resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name        = "${local.prefix}-nat-eip"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/nat-gateway.tf"
  }
}

resource "aws_nat_gateway" "nat" {
  subnet_id = "${aws_subnet.public-subnet-1.id}"
  allocation_id = aws_eip.nat.id
  tags = {
    Name        = "${local.prefix}-nat-gateway"
    Environment = local.env
    Path        = "${basename(abspath(path.module))}/nat-gateway.tf"
  }
}
