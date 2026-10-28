resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "ecommerce-db-subnet-group"
  subnet_ids = aws_subnet.private_app_subnets[*].id
  tags = { Name = "ecommerce-db-subnets" }
}

resource "aws_security_group" "db_sg" {
  name        = "database-sg"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "13.4"
  instance_class         = "db.t3.micro"
  db_name                = "ecommercedb"
  username               = "admin"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
  multi_az               = false # Set to true for production
    }
