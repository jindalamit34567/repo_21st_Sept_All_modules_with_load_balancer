variable "subnet_name" {
  
}

variable "resource_group_name" {
  
}
# variable "subnet_virtual_network_name" {
  
# }

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}
variable "address_prefixes" {
  type = list(string)
}