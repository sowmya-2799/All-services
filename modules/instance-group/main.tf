resource "google_compute_instance_template" "this" {
  project      = var.project_id
  name_prefix  = var.instance_template_name_prefix
  machine_type = var.machine_type
  tags         = var.backend_tags

  disk {
    source_image = "debian-cloud/debian-12"
    auto_delete  = true
    boot         = true
    disk_size_gb = 20
    disk_type    = "pd-balanced"
  }

  network_interface {
    subnetwork = var.subnetwork_self_link
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    set -euo pipefail
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y apache2
    printf 'Regional managed instance group backend is healthy.\n' > /var/www/html/index.html
    systemctl enable --now apache2
  EOF

  dynamic "service_account" {
    for_each = var.service_account_email == null ? [] : [var.service_account_email]

    content {
      email  = service_account.value
      scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_instance_group_manager" "this" {
  project            = var.project_id
  name               = var.name
  region             = var.region
  base_instance_name = var.instance_base_name
  target_size        = var.target_size

  version {
    name              = "primary"
    instance_template = google_compute_instance_template.this.self_link
  }

  named_port {
    name = "http"
    port = var.backend_port
  }
}