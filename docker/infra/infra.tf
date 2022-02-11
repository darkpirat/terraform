
resource "docker_network" "wordpress_net" {
  name = "wordpress_net"
}

# Create a docker image resource
# -> docker pull httpd:latest
resource "docker_image" "tetris" {
  name = "uzyexe/tetris:latest"
}

# Create a docker container resource
# -> same as 'docker run --name web1 -p 8086:80 -d apache:latest'
resource "docker_container" "tetris1" {
  name  = "tetris1"
  image = docker_image.tetris.latest

  ports {
    external = 8080
    internal = var.internal_port
  }
}

module "web1" {
  source                  = "./modules/apache"
  container_name          = "web1"
  container_external_port = 8081
}

module "wordpress1" {
  source                  = "./modules/wordpress"
  container_name          = "wordpress1"
  container_external_port = 8082
  container_network       = "wordpress_net"
}

module "database1" {
  source                  = "./modules/mysql"
  container_name          = "database1"
  container_network       = "wordpress_net"
}