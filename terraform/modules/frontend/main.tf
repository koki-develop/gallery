module "head" {
  source = "./head"
}

data "html_html" "main" {
  children = [module.head.html]
}
