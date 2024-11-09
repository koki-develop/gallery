data "html_main" "main" {
  id    = "app"
  class = "py-4 px-2 container mx-auto flex-grow"
  children = [
    module.templates.html,
    data.html_div.loader.html,
    data.html_dialog.modal.html,
  ]
}

module "templates" {
  source = "../templates"
}

data "html_div" "loader" {
  id       = "loader"
  class    = "text-center text-xl"
  children = ["Loading..."]
}

data "html_dialog" "modal" {
  id       = "modal"
  class    = "p-0 outline-none backdrop:bg-black/80"
  children = []
}
