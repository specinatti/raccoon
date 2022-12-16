# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "private" {
  name                     = "private"
  ip_cidr_range            = "10.219.189.64/27"
  region                   = var.region
  network                  = google_compute_network.main.name
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "raccoon-private-pods"
    ip_cidr_range = "10.219.198.0/24"
  }

  secondary_ip_range {
    range_name    = "raccoon-private-services"
    ip_cidr_range = "10.219.200.0/24"
  }
}
