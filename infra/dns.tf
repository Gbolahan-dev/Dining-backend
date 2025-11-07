# infra/dns.tf

# Fetch DuckDNS token from Secret Manager
data "google_secret_manager_secret_version" "duckdns_token" {
  project = var.project_id
  secret  = var.duckdns_token_secret_id
}

# Fetch Ingress IPs dynamically
data "kubernetes_ingress" "staging_ingress" {
  metadata {
    name      = "inu-dining-staging-dining-backend"
    namespace = kubernetes_namespace.staging.metadata[0].name
  }
  depends_on = [helm_release.staging]
}

data "kubernetes_ingress" "prod_ingress" {
  metadata {
    name      = "inu-dining-prod-dining-backend"
    namespace = kubernetes_namespace.prod.metadata[0].name
  }
  depends_on = [helm_release.production]
}

# Update DNS automatically when IPs change
resource "null_resource" "dns_update" {
  triggers = {
    staging_ip = data.kubernetes_ingress.staging_ingress.status[0].load_balancer[0].ingress[0].ip
    prod_ip    = data.kubernetes_ingress.prod_ingress.status[0].load_balancer[0].ingress[0].ip
    token      = data.google_secret_manager_secret_version.duckdns_token.secret_data
  }
provisioner "local-exec" {
    command = <<EOF
curl "https://www.duckdns.org/update?domains=inu-dining-api&token=${self.triggers.token}&ip=${self.triggers.staging_ip}"
curl "https://www.duckdns.org/update?domains=api-prod&token=${self.triggers.token}&ip=${self.triggers.prod_ip}"
EOF
  }
}
