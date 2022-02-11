variable "container_name" {
  description = "le nom du conteneur"
  type        = string
  default     = "apache1"
}

variable "internal_port" {
  description = "Port interne du conteneur"
  type        = number
  default     = 80
}

