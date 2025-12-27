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

  allow_stopping_for_update = true


  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
      type  = "pd-standard"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      # this will give the VM a external IP
    }
  }

  service_account {
    email = null
    # This scope allows the VM to interact with all Google Cloud services 
    # that the Service Account has IAM permissions for.
    scopes = ["cloud-platform"]
  }
}


