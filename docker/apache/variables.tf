variable "container_name" {
  description = "le nom du conteneur"
  type        = string
  default     = "apache1"
}

variable "external_port" {
  description = "Port externe du conteneur"
  type        = number
  default     = 8086
}

variable "internal_port" {
  description = "Port interne du conteneur"
  type        = number
  default     = 80
}