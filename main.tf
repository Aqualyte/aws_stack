provider "aws" {
 region = "${var.aws_region}"
 profile = "default"
}

module "network" {
  source = "./network"
  namespace = "${var.namespace}"
}

resource "aws_instance" "main" {
 ami = "${var.aws_instance_ami}"
 instance_type = "${var.aws_instance_type}"
 subnet_id = "${module.network.subnet_ids}"
 vpc_security_group_ids = ["${module.network.security_group_id}"]
 key_name = "${var.ssh_key_name}"

 tags = {
  Name = "${var.namespace}-instance"
 }
}
