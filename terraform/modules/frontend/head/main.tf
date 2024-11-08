data "html_head" "main" {
  children = [
    data.html_meta.charset.html,
    data.html_meta.viewport.html,
    data.html_title.main.html,
    data.html_script.tailwind.html,
  ]
}

data "html_meta" "charset" {
  charset = "UTF-8"
}

data "html_meta" "viewport" {
  name    = "viewport"
  content = "width=device-width, initial-scale=1.0"
}

data "html_title" "main" {
  children = ["Gallery"]
}

data "html_script" "tailwind" {
  src = "https://cdn.tailwindcss.com"
}
