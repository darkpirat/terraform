variable "database_name" {
  description = "le nom de la db"
  type        = string
  default     = "testdatabase"
}

variable "database_user" {
  description = "login user de la db"
  type        = string
  default     = "user"
}

variable "database_password" {
  description = "password user de la db"
  type        = string
  default     = "password"
}

variable "container_db_name" {
  description = "le nom du container db"
  type        = string
  default     = "database1"
}

variable "container_wp_name" {
  description = "le nom du conteneur wordpress"
  type        = string
  default     = "wordpress1"
}
