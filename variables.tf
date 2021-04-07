/*
variable "resource_group" {
  type        = string
  description = "Resource Group to deploy NVA"
}

*/
variable "subscription_id" {
  type        = string
  description = "Suscripcion sobre la que se va a trabajar"
 }

variable "loc" {
  type        = string
  description = "Ubicacion"
  default ="westeurope"
}
variable "FrontEndSubnetprefix" {
  type        = any
  default     = "172.16.0.0/25"
}
variable "BackEndSubnetprefix" {
  type        = any
  default     = "172.16.0.128/25"
}
variable "pass"{
    type        = string
}
variable "w10Subnetprefix" {
  type        = any
  default     = "172.16.0.128/25"
}