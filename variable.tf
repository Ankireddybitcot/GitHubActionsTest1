
/*
variable "accesskey" {
    type = "string"
    default = "AKIAWBEP2BYJSWMCCME6"
}

variable "secretkey" {
   type = "string"
   default ="LlfHPILHlVbk7dQ59Wq9Ye0HZ9vdvR62KRf3+OX1"
}

variable "region" {
    type = "string"
    default = "us-west-2"
}
*/

variable "name" {
    type = "string"
    #description = "Enter name of your account"  
    default = "anki2"
}
variable "threshold" {
    type = "string"
    #description = "pass the percentage threshold to get alarms"  
    default = "30"
}

variable "email" {
    type = "string"
    #description = "Enter email to get notification"
    default = "ankireddy@bitcot.com"
  
}

variable "limitamount" {
    #description = "enter value of limit amount USD (eg. 1 , 2 , 50 ,100) "
    default = "1"

}
/*
variable "timeunit" {
    type = "string"
    description = "Enter time_unit (eg .  MONTHLY, QUARTERLY, ANNUALLY ) "
  
}
*/
