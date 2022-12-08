variable "iam_roles" {
    type = map
    description = "iam role to be created in the target account" 
    default = {}
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

