data "html_main" "main" {
  id    = "app"
  class = "py-4 px-2 container mx-auto flex-grow"
  children = [
    module.templates.html,
    data.html_div.loader_container.html,
    data.html_dialog.modal.html,
  ]
}

module "templates" {
  source = "./templates"
}

data "html_div" "loader_container" {
  class    = "flex justify-center"
  children = [data.html_div.loader.html]
}

data "html_div" "loader" {
  id       = "loader"
  class    = "loader light"
  children = []
}

data "html_dialog" "modal" {
  id       = "modal"
  class    = "p-0 outline-none backdrop:bg-black/80"
  children = []
}
