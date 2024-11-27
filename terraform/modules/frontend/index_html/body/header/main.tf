data "html_header" "main" {
  class = "flex flex-col items-center py-4 border-b"
  children = [
    data.html_h1.main.html,
    data.html_p.powered_by.html,
  ]
}

data "html_h1" "main" {
  class    = "text-3xl"
  children = ["Gallery"]
}

data "html_p" "powered_by" {
  children = [
    "Powered by",
    " ",
    data.html_a.lorem_picsum.html,
  ]
}

data "html_a" "lorem_picsum" {
  class    = "text-blue-500 hover:opacity-80"
  href     = "https://picsum.photos"
  target   = "_blank"
  rel      = "noopener"
  children = ["Lorem Picsum"]
}
