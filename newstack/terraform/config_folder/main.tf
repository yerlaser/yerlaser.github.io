resource "kubernetes_deployment" "kub-test-res" {
  metadata {
    name = "kub-test-metadata-name"
    # labels = {
    #   App = "kub-test-lab"
    # }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "kub-test-lab"
      }
    }
    template {
      metadata {
        labels = {
          App = "kub-test-lab"
        }
      }
      spec {
        container {
          image = "nginx:latest"
          name = "kub-test-cont"
          port {
            container_port = 80
          }
          resources {
            limits = {
              cpu = "0.5"
              memory = "50Mi"
            }
            requests = {
              cpu = "10m"
              memory = "25Mi"
            }
          }
        }
      }
    }
  }
}
