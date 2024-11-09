data "html_script" "main" {
  children = [data.js_program.main.content]
}

data "js_program" "main" {
  contents = []
}
