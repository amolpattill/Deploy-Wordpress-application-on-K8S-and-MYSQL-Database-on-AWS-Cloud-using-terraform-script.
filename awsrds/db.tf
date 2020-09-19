provider "aws" {
  region = "ap-south-1"
  profile = "amol"
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = ["subnet-080c9907eda955efe", "subnet-0c0dff70e4854ded4", "subnet-0e244f391bebe248b"]
  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_db_instance" "mydb" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.30"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "amol"
  password             = "amol123456"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible = true
  db_subnet_group_name = "${aws_db_subnet_group.default.name}"
  iam_database_authentication_enabled = true
  skip_final_snapshot = true
  port = "3306"
  tags = {
    "Name" = "database-1"
  }
}
output "ip" {
    value = "${aws_db_instance.mydb.address}"
  
}