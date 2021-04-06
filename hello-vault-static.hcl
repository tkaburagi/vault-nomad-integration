job "vault-secret-zero-static" {
  datacenters = ["dc1"]

  type = "service"

  group "vault-secret-zero-static" {
    task "vault-secret-zero-static" {
      driver = "java"
      config {
        jar_path    = "/Users/kabu/hashicorp/vault/secret-zero/nomad/app/target/vault-secret-zero-nomad-0.0.1-SNAPSHOT.jar"
        jvm_options = ["-Xmx2048m", "-Xms256m"]
      }
      vault {
        policies    = ["read-kv-db"]
        change_mode = "restart"
      }
      template {
        data        = <<EOH
          "{{with secret "kv-nomadapp/my-db"}}{{.Data.password}}{{end}}"
          EOH
        destination = "${NOMAD_SECRETS_DIR}/test-secret"
      }
      resources {
        cpu    = 500
        memory = 1024

        network {
          mbits = 10
          port "http" {}
        }
      }
    }
  }
}
