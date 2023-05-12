resource "aws_launch_configuration" "orion_lauch_config" {
  name_prefix   = "lauch_config"
  image_id      = data.aws_ami.default_ami.id
  instance_type = "t2.micro"
}

data "aws_subnets" "default_subnet" {
  #vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}


data "aws_vpc" "default_vpc" {
  filter {
    name   = "isDefault"
    values = ["true"]
  }
}

output "default_vpc_id" {
  value = data.aws_vpc.default_vpc.id
}

output "default_subnet_ids" {
  value = data.aws_subnets.default_subnet.ids
}

resource "aws_autoscaling_group" "orion_asg" {
  name                 = "auto scaling"
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.orion_lauch_config.name
  vpc_zone_identifier  = data.aws_subnets.default_subnet.ids
}
#Getting latest ami

data "aws_ami" "default_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}