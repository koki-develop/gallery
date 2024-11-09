data "html_body" "main" {
  class = "min-h-dvh flex flex-col"
  children = [
    module.header.html,
    module.main.html,
    module.footer.html,
  ]
}

module "header" {
  source = "./header"
}

module "main" {
  source = "./main"
}

module "footer" {
  source = "./footer"
}
