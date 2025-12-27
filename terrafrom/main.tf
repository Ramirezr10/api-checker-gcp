# VPC network
resource "google_compute_network" "vpc_network" {
  name = "health-checker-network"

}


# SSH rule
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]

  }

  source_ranges = ["0.0.0.0/0"] #just to access

}

# Virutal machine image
resource "google_compute_instance" "vm_instance" {
  name         = "health-checker-vm"
  machine_type = "e2-micro"
  zone         = "${var.region}-a"


  boot_disk {
    initialize_params {
      image = "ubuntu-cloud/ubuntu-22"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      # this will give the VM a external IP
    }
  }


}
