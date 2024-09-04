## 

data "aws_ami" "amzl2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["${var.ami_id}"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "user_data" {
  template = file("${local.user_data_tpl}")
  vars = {
    instance_name   = lower(var.instance1)
    curr_pass       = data.vault_kv_secret_v2.terraformsecret.data["ansible_pass"]
    ansible_ssh_key = data.vault_kv_secret_v2.terraformsecret.data["ansible_ssh_key"]
  }
}

resource "aws_instance" "vm1" {
  instance_type               = var.aws_family
  ami                         = data.aws_ami.amzl2.id
  subnet_id                   = var.aws_subnet
  vpc_security_group_ids      = [var.aws_security_group]
  associate_public_ip_address = false

  key_name         = "aws_key"
  user_data_base64 = base64encode(data.template_file.user_data.rendered)

  root_block_device {
    delete_on_termination = true
    volume_type           = local.disk_type
    volume_size           = local.disk_size_gb

    tags = {
      name         = var.instance1
      Name         = var.instance1
    }
  }
      tags = {
      name         = var.instance1
      Name         = var.instance1
    }
}

resource "aws_ebs_volume" "ebs_volume" {
  count             = var.disk_info != null ? length(var.disk_info) : 0
  availability_zone = aws_instance.vm1.availability_zone
  type              = local.disk_type
  size              = var.disk_info[count.index].disk_size_gb
  encrypted         = true
  tags = {
    name         = "${var.instance1}-disk${count.index + 1}"
    Name         = "${var.instance1}-disk${count.index + 1}"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  count       = var.disk_info != null ? length(var.disk_info) : 0
  device_name = var.disk_info[count.index].device_name
  volume_id   = aws_ebs_volume.ebs_volume[count.index].id
  instance_id = aws_instance.vm1.id
}


## * This section will print the ip address of the virtual machine
output "vm1_private_ip_address" {
  value = aws_instance.vm1.private_ip
}

output "vm1_private_dns" {
  value = aws_instance.vm1.private_dns
}
