variable "ASG_name" {
  type    = string
  default = "Cloud_clan_ASG"
}


variable "max_size" {
  type = string
}
variable "min_size" {
  type = string

}
variable "vpc_subnet_ids" {
  type    = any
  default = []
}

variable "image_id" {
  type    = string
  default = "ami-02011e53045b9918e"
}

variable "volume_size" {
  type    = string
  default = "Cloud_clan_launch_template"
}

variable "target_arn" {
  type    = list(string)
  default = []
}
variable "sg_ids" {
  type    = list(string)
  default = []
}
variable "profile_name" {
  type = string
}
