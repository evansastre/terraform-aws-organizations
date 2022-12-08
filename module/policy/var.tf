variable "scp" {
    type = map  
    description = "scp to be created"
    default = {}
  
}


variable "tag-policy" {
    type = map  
    description = "tag policy to be created"
    default = {}
  
}

variable "policy_attachment" {
    type = map  
    description = "attach the scp to a specific OU/account id"
    default = {}
  
}

variable "dir_name" {
    type = string
    default = "source/scp-policy"
  
}
