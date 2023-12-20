module "container_glrunner_java21" {
  source    = "github.com/studio-telephus/tel-iac-modules-lxd.git//instance?ref=develop"
  name      = "container-glrunner-java21"
  image     = "images:debian/bookworm"
  profiles  = ["limits", "fs-dir", "nw-adm"]
  autostart = true
  nic = {
    name = "eth0"
    properties = {
      nictype        = "bridged"
      parent         = "adm-network"
      "ipv4.address" = "10.0.10.135"
    }
  }
  mount_dirs = [
    "${path.cwd}/filesystem-shared-ca-certificates",
    "${path.cwd}/filesystem",
  ]
  exec = {
    enabled    = true
    entrypoint = "/mnt/install.sh"
    environment = {
      RANDOM_STRING                  = "efbe6178-2934-4588-ac71-6435cabc02dd"
      GITLAB_RUNNER_REGISTRATION_KEY = var.gitlab_runner_registration_key
      GIT_SA_USERNAME                = var.git_sa_username
      GIT_SA_TOKEN                   = var.git_sa_token
    }
  }
}
