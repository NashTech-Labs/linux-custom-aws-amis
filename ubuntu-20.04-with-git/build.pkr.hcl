# Variables
variable "ami_name" {
  type    = string
  default = "ubuntu-focal-20.04-amd64-with-git"
}

variable "region" {
  type = string
  description = "Region in which the image should be created"
  default = "us-east-1"
}


source "amazon-ebs" "ubuntu" {
  ami_name      = var.ami_name
  instance_type = "t2.micro"
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tags = {
    OS_Version        = "Ubuntu 20.04"
    Release           = "Latest"
    Base_AMI_Name     = "{{ .SourceAMIName }}"
    Extra             = "{{ .SourceAMITags.TagName }}"
    Preinstalled_Tool = "Git"
  }
}

build {
  name = "ubuntu-20.04-with-git"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "file" {
    source      = "./scripts/install-git.sh"
    destination = "/tmp/install-git.sh"
  }

  provisioner "shell" {
    inline = [
      "echo Installing Git",
      "sleep 30",
      "bash /tmp/install-git.sh",
      "git --version",
      "sudo rm -v /tmp/install-git.sh",
    ]
  }

  post-processor "shell-local" {
    inline = ["echo Build finish"]
  }
}
