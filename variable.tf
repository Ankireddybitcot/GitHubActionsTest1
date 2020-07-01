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
