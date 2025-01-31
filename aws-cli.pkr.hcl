packer { 
    required_plugins {
        amazon = {
            version = "~> 1"
            source  = "github.com/hashicorp/amazon"
        }
    }
}

variable "aws_access" {
    type = string
    default = ""
}

variable "aws_secret" {
    type = string
    default = ""
}

data "amazon-ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
}

source "amazon-ebs" "ubuntu" {
    ami_name      = "ubuntu-ami"
    instance_type = "t4g.micro"
    region        = "us-west-2"
    ssh_username  = "ubuntu"
    source_ami    = "${data.amazon-ami.ubuntu.id}"
    run_tags = {
        Name = "ubuntu-ami"
        owner = "Packer"
        Environment = "Dev"
    }
}
    

build {
    name = "ubuntu-ami"
    sources = ["source.amazon-ebs.ubuntu"]

    provisioner "shell" {
        inline = [
            "sudo apt-get update",
            "sudo apt-get install -y apache2"
        ]
    }

    provisioner "file" {
        source      = "/Users/ansh/Documents/VS code/AMI/aws-cli.sh"
        destination = "/tmp/aws-cli.sh"
    }
}


