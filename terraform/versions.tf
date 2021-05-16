terraform {
  required_version = ">= 0.15.3"

  required_providers {
    aws      = ">= 3.40.0"
    local    = ">= 2.1.0"
    template = ">= 2.2.0"
    tls      = ">= 3.1.0"
  }
}
