resource "kubernetes_deployment" "kub_test_res" {
  metadata {
    name = "kub-test-name"
    labels = {
      App = "kub_test_lab"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "kub_test_lab"
      }
    }
    template {
      metadata {
        labels = {
          App = "kub_test_lab"
        }
      }
      spec {
        container {
          image = "debian:latest"
          name = "kub-test-cont"
          port {
            container_port = 80
          }
          resources {
            limits = {
              cpu = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu = "100m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

