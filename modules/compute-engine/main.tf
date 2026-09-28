resource "google_compute_instance" "this" {
  project                   = var.project_id
  name                      = var.vm_name
  zone                      = var.zone
  machine_type              = var.machine_type
  allow_stopping_for_update = true
  deletion_protection       = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = var.subnetwork_self_link
  }

  dynamic "service_account" {
    for_each = var.service_account_email == null ? [] : [var.service_account_email]

    content {
      email  = service_account.value
      scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    }
  }
}