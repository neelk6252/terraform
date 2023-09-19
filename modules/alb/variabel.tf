variable "alb-name" {
  type    = string
  default = "Transbnk"
}

variable "ALB-TG-Name" {
  type    = string
  default = "Transbnk-TG"
}
variable "security-groups" {
  type    = any
}
variable "subnetsids" {
  type    = list(string)
}

variable "vpc_id" {
  type = any
}

variable "listener_port" {
  type = string
  default = "8080"
}
variable "listener_protocol" {
  type = string
  default = "HTTP"
}