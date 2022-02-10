
# Create a docker image resource
# -> docker pull nginx:latest
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Create a docker container resource
# -> same as 'docker run --name web1 -p 8000:80 -d nginx:latest'
resource "docker_container" "web1" {
  name  = var.container_name
  image = docker_image.nginx.latest

  ports {
    external = 8000
    internal = 80
  }
}