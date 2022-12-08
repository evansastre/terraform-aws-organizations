variable "name" {
    type = string
    description = "name of this cloudformation stackset" 
    default = ""
}

variable "permission_model" {
    type = string 
    description = "Describes how the IAM roles required for your StackSet are created"
    default = "SERVICE_MANAGED"
  
}

variable "tags" {
    type = map
    description = "tags"
    default = {}
  
}

variable "region" {
     type = string 
     description = "region"
     default = "ap-southeast-1"  
}


variable "organizational_unit_id" {
    type = list
    description = "list of organizational_unit_id"
    default = []
}