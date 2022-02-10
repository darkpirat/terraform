
# Create a docker image resource
# -> docker pull httpd:latest
resource "docker_image" "apache" {
  name = "httpd:latest"
}

# Create a docker container resource
# -> same as 'docker run --name web1 -p 8086:80 -d apache:latest'
resource "docker_container" "web1" {
  name  = var.container_name
  image = docker_image.apache.latest

  ports {
    external = var.external_port
    internal = var.internal_port
  }
}