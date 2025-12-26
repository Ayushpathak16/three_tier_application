variable "rgname" { default = "ayushrg" }
variable "rglocation" { default = "East Asia" }

variable "vnet_name" { default = "ayush-vnet" }

variable "frontsubnet_name" { default = "frontend-subnet" }
variable "backsubnet_name"  { default = "backend-subnet" }
variable "dbsubnet_name"    { default = "db-subnet" }

variable "frontip_name"     { default = "frontend-ip" }

variable "frontendnic_name" { default = "frontend-nic" }
variable "backendnic_name"  { default = "backend-nic" }
variable "dbnic_name"       { default = "db-nic" }
