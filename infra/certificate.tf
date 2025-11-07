# Create new file: infra/certificate.tf

resource "google_compute_managed_ssl_certificate" "staging_cert" {
  project = var.project_id
  name    = "inu-dining-staging-cert"

  managed {
    domains = [var.staging_hostname]
  }
}

resource "google_compute_managed_ssl_certificate" "prod_cert" {
  project = var.project_id
  name    = "inu-dining-prod-cert"

  managed {
    domains = [var.prod_hostname]
  }
}
