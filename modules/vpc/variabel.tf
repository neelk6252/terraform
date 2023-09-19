variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet-1a" {
  type    = string
  default = "10.0.10.0/24"
}

variable "public_subnet-1b" {
  type    = string
  default = "10.0.20.0/24"
}
variable "private_subnet-1a" {
  type    = string
  default = "10.0.30.0/24"
}
variable "private_subnet-1b" {
  type    = string
  default = "10.0.40.0/24"
}

variable "availability-zone-1a" {
  description = "Provide availability zone for your subnet"
  type        = string
  default     = "us-east-1a"

}

variable "availability-zone-1b" {
  description = "Provide availability zone for your subnet"
  type        = string
  default     = "us-east-1b"

}


variable "dna-ip" {
  description = "provid the value in true or false "
  type        = bool
  default     = "true"

}