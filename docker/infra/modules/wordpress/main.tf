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
# -> docker pull wordpress:latest
resource "docker_image" "wp" {
  name = "wordpress:latest"
}

resource "docker_volume" "wp_vol_wp" {
    name = "wp_vol_wp"
}

# Create a docker container resource
# -> same as 'docker run --name wp -p 9000:80 -d wordpress:latest'
resource "docker_container" "wp" {
  name  = var.container_name
  image = docker_image.wp.latest
  network_mode = var.container_network
  restart = "always"
  ports {
    internal = 80
    external = var.container_external_port
  }
  env = [
      "WORDPRESS_DB_HOST=database1",
      "WORDPRESS_DB_USER=user",
      "WORDPRESS_DB_PASSWORD=password",
      "WORDPRESS_DB_NAME=wordpressdb"
  ]
  mounts  {
    type = "volume"
    target = "/var/www/html"
    source = "wp_vol_wp"
  }
}
