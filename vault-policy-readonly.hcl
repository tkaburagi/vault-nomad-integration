path "kv-nomadapp/my-db" {
  capabilities = ["read"]
}
path "database/creds/*" {
  capabilities = ["read"]
}
