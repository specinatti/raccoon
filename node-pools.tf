# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "kubernetes" {
  account_id   = "k8s-terraform-user"
  display_name = "k8s-terraform-user"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.k8s-raccoon-cluster.id
  node_count = var.nodecount

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = var.nodetype

    labels = {
      "role" = "general"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
