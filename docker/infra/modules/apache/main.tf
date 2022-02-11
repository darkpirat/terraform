# Set the required provider and versions
terraform {
  required_providers {
    # We recommend pinning to the specific version of the Docker Provider you're using
    # since new versions are released frequently
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}


# Create a docker image resource
# -> docker pull httpd:latest
resource "docker_image" "apache" {
  name = "httpd:latest"
}

# Create a docker container resource
resource "docker_container" "apache" {
  name  = var.container_name
  image = docker_image.apache.latest

  ports {
    external = var.container_external_port
    internal = 80
  }
}