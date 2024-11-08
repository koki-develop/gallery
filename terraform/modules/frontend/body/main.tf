data "html_body" "main" {
  class = "min-h-dvh flex flex-col"
  children = [
    module.header.html,
    module.footer.html,
  ]
}

module "header" {
  source = "./components/header"
}

module "footer" {
  source = "./components/footer"
}
