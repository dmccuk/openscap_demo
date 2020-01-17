variable "AWS_REGION" {
  default = "eu-west-2"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-2 = "ami-09061756a54275ff6"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "sshkey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "sshkey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}
