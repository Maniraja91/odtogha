provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "odgha_key" {
  key_name   = var.key_name
  public_key = var.public_key
}

data "aws_security_group" "existing_allow_all_traffic" {
  filter {
    name   = "group-name"
    values = ["allow_all_traffic"]
  }
}

resource "aws_security_group" "allow_all_traffic" {
  count = data.aws_security_group.existing_allow_all_traffic.id == null ? 1 : 0

  name        = "allow_all_traffic"
  description = "Allow all inbound and outbound traffic"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "octopus_deploy" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.odgha_key.key_name

  vpc_security_group_ids = data.aws_security_group.existing_allow_all_traffic.id != null ? [data.aws_security_group.existing_allow_all_traffic.id] : [aws_security_group.allow_all_traffic[0].id]

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }

  user_data = <<EOF
<powershell>
# Update system
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Download and install Octopus Deploy Server prerequisites
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://octopus.com/downloads/latest/WindowsServer" -OutFile "C:\OctopusDeploy.msi"
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i C:\OctopusDeploy.msi /quiet" -Wait

# Start Octopus Deploy Server
Start-Service -Name "OctopusDeploy"
</powershell>
EOF

  tags = {
    Name = "Octopus-Deploy-Server"
  }
}

output "instance_public_ip" {
  value = aws_instance.octopus_deploy.public_ip
}