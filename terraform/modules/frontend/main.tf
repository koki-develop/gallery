module "head" {
  source = "./head"
}

module "body" {
  source = "./body"
}

data "html_html" "main" {
  children = [module.head.html, module.body.html]
}
