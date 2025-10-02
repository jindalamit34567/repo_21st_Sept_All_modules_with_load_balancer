
variable "lb_name" {
  description = "The name of the Load Balancer."
  type        = string
  
}

variable "location" {
  description = "The Azure region where the Load Balancer will be created."
  type        = string
  
}

variable "frontend_ip_name" {
  description = "The name of the frontend IP configuration."
  type        = string
  
}

variable "public_ip_name" {
  description = "The name of the existing Public IP to associate with the Load Balancer."
  type        = string
  
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Load Balancer."
  type        = string
  
}

variable "probe_name" {
  description = "The name of the load balancer probe."
  type        = string
  
}

variable "my_backend_pool" {
  description = "The name of the backend address pool."
  type        = string
  
}

variable "lb_rule" {
  
}