terraform {
  backend "s3" {
    bucket       = "terraform-tfstate-stg"
    key          = "stg/devops/apne2/devops.tfstate"
    region       = "ap-northeast-2"
    use_lockfile = true
  }
}
