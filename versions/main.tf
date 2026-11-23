# Central versions of the platform tools (data only: nobody runs Terraform on this file).
# The Tools Agent reads it and writes these versions into each cluster folder of the gitops repo.
#
#   version  = exact chart version (one per tool; tools with several releases use it for all of them).
#   required = true  -> mandatory: ALWAYS installed, a team cannot remove it.
#   required = false -> optional: offered; installed ONLY when the team selects it (GP04 / --optional).
#
# What a team selected is never stored here: it lives in that cluster's folder in the gitops repo.
# Changing a version or making a tool mandatory = PR to this repo + new tag tools-vX.Y.Z.

locals {
  tools = {
    argo-cd = { version = "10.18.0", required = true }
    # AWS only (catalog clouds: [aws]); mandatory there, never selected on Azure.
    aws-load-balancer-controller = { version = "3.6.3", required = true }
    cert-manager                 = { version = "v1.21.3", required = false }
    istio                        = { version = "1.30.8", required = false }
    kyverno                      = { version = "3.10.0", required = false }
    gatekeeper                   = { version = "3.23.1", required = false }
    vault                        = { version = "0.34.1", required = false }
    external-secrets             = { version = "2.15.0", required = false }
    kube-prometheus-stack        = { version = "93.4.0", required = false }
    opentelemetry-operator       = { version = "0.129.1", required = false }
    flux                         = { version = "2.20.0", required = false }
  }
}
