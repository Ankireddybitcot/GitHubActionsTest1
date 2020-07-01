/*variable "VPC" {
    type = string
    #description = "Enter vpc cidr range (eg. 10.0.0.0/16 )"
    default = "10.0.0.0/16"
}
variable "public_subnets_cidr" {
    type = list
    #description = "Enter public_subnets_cidr type as list (eg: [10.0.1.0/24,10.0.3.0/24]  )"
    default = ["10.0.1.0/24","10.0.3.0/24"]

}
variable "azs" {
    type = list
   # description = "Enter Availability_zone type as list (eg : [us-west-2a,us-west-2b])"
   default = ["us-west-2a","us-west-2b"]
  
}
variable stack {
  #description = "Enter name for tags"
  default = "anki"
}
variable "private_subnets_cidr" {
    type = list
    #description = "Enter private_subnets_cidr type as list (eg: [10.0.2.0/24,10.0.4.0/24] )"
    default = ["10.0.2.0/24","10.0.4.0/24"]
    
  }
  */

variable "VPC" {
    type = "string"
    #description = "Enter vpc cidr range (eg. 10.0.0.0/16 )"
    default = "10.0.0.0/16"
}
variable "public_subnets_cidr" {
    type = "list"
    #description = "Enter public_subnets_cidr type as list (eg: [10.0.1.0/24,10.0.3.0/24]  )"
    default = ["10.0.1.0/24","10.0.3.0/24"]

}

variable "private_subnets_cidr" {
    type = "list"
    #description = "Enter private_subnets_cidr type as list (eg: [10.0.2.0/24,10.0.4.0/24] )"
    default = ["10.0.2.0/24","10.0.4.0/24"]
    
  
}

variable "azs" {
    type = "list"
   # description = "Enter Availability_zone type as list (eg : [us-west-2a,us-west-2b])"
   default = ["us-west-2a","us-west-2b"]
  
}
/*
variable "accesskey" {
    type = "string"
    #description = "Enter access_key"
    
}

variable "secretkey" {
   type = "string"
   description = "Enter secret_key"
   
}

variable "region" {
    type = "string"
    description = "Enter region name (eg. us-west-2 , us-east-1 , etc)"
    
}
*/
variable stack {
  #description = "Enter name for tags"
  default = "anki"
}
