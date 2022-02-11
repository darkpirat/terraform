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
# -> docker pull mysql:latest
resource "docker_image" "db" {
  name = "mysql:latest"
}

resource "docker_volume" "wp_vol_db" {
    name = "wp_vol_db"
}

resource "docker_container" "db" {
  name  = var.container_name
  image = docker_image.db.latest
  network_mode = var.container_network
  restart = "always"
  env = [
      "MYSQL_DATABASE=wordpressdb",
      "MYSQL_USER=user",
      "MYSQL_PASSWORD=password",
      "MYSQL_ROOT_PASSWORD=password"
  ]
  mounts  {
    type = "volume"
    target = "/var/lib/mysql"
    source = "wp_vol_db"
  }
}
