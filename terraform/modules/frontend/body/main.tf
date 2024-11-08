data "html_body" "main" {
  class = "min-h-dvh flex flex-col"
  children = [
    module.header.html,
    module.main.html,
    module.footer.html,
  ]
}

module "header" {
  source = "./components/header"
}

module "main" {
  source = "./components/main"
}

module "footer" {
  source = "./components/footer"
}
