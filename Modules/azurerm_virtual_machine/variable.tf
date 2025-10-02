variable "nic_name" {
  description = "The name of the network interface."
  type        = string              
  
}

variable "ip_name" {
  description = "The name of the IP configuration."
  type        = string              
  
}

variable "location" {
  description = "The Azure region where the network interface will be created."
  type        = string              
  
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the network interface."
  type        = string              
  
}

variable "subnet_name" {
  description = "The name of the subnet to which the network interface will be connected."
  type        = string              
  
}

variable "virtual_network_name" {
  description = "The name of the virtual network containing the subnet."
  type        = string              
  
}

variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
  
}


variable "vm_name" {
  
}

variable "admin_password" {
  description = "The password for the admin user"
  type        = string
  sensitive   = true
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
}

variable "publisher" {
  description = "The publisher of the image to use."
  type        = string
  
}

variable "offer" {
  description = "The offer of the image to use."
  type        = string
  
} 
variable "sku" {
  description = "The SKU of the image to use."
  type        = string
  
}

variable "image_version" {
  
}