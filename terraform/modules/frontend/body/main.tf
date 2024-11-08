module "header" {
  source = "./components/header"
}

data "html_body" "main" {
  children = [
    module.header.html,
  ]
}
