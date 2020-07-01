variable "VPC" {
    type = string
    #description = "Enter vpc cidr range (eg. 10.0.0.0/16 )"
    default = "10.0.0.0/16"
}
variable "public_subnets_cidr" {
    type = list
    #description = "Enter public_subnets_cidr type as list (eg: [10.0.1.0/24,10.0.3.0/24]  )"
    default = ["10.0.1.0/24","10.0.3.0/24"]

}
variable stack {
  #description = "Enter name for tags"
  default = "anki"
}