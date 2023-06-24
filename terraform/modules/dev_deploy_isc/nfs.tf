resource "aws_efs_file_system" "efs-server" {
  creation_token = "obligatorio-efs"

  tags = {
    Name = "obligatorio-efs"
  }
}

resource "aws_efs_mount_target" "shared-nfs1" {
  file_system_id  = aws_efs_file_system.efs-server.id
  subnet_id       = aws_subnet.pub_subnet1_obligatorio.id
  security_groups = [aws_security_group.efs-sg.id]
  
}

resource "aws_efs_mount_target" "shared-nfs2" {
  file_system_id  = aws_efs_file_system.efs-server.id
  subnet_id       = aws_subnet.pub_subnet2_obligatorio.id
  security_groups = [aws_security_group.efs-sg.id]
  
}