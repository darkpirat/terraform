output "image_id" {
  value = docker_image.nginx.id
}

output "container_id" {
  description = "ID du conteneur web1"
  value       = docker_container.web1.id
}