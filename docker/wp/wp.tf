# Create a docker image resource
# -> docker pull wordpress:latest
resource "docker_image" "wp" {
  name = "wordpress:latest"
}

# Create a docker image resource
# -> docker pull mysql:latest
resource "docker_image" "db" {
  name = "mysql:latest"
}

resource "docker_network" "wordpress_net" {
  name = "wordpress_net"
}

resource "docker_volume" "wp_vol_web" {
    name = "wp_vol_web"
}

resource "docker_volume" "wp_vol_db" {
    name = "wp_vol_db"
}

# Create a docker container resource
# -> same as 'docker run --name wp -p 9000:80 -d wordpress:latest'
resource "docker_container" "wp" {
  name  = var.container_wp_name
  image = docker_image.wp.latest
  network_mode = "wordpress_net"
  restart = "always"
  ports {
    internal = 80
    external = 9000
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

resource "docker_container" "db" {
  name  = var.container_db_name
  image = docker_image.db.latest
  network_mode = "wordpress_net"
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
