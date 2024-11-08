data "html_footer" "main" {
  class = "pt-12 pb-16 flex flex-col justify-center items-center border-t"
  children = [
    data.html_span.copyright.html,
    data.html_a.github.html,
  ]
}

data "html_span" "copyright" {
  children = ["&copy;2024 Koki Sato"]
}

data "html_a" "github" {
  class    = "text-blue-500 hover:opacity-80"
  href     = "https://github.com/koki-develop/gallery"
  target   = "_blank"
  rel      = "noopener"
  children = ["View on GitHub"]
}
