data "html_script" "main" {
  children = [data.js_program.main.content]
}

data "js_program" "main" {
  contents = [
    module.function_main.this.content,
    data.js_function_call.main.content,
  ]
}

module "function_main" {
  source = "./functions/main"
}

data "js_function_call" "main" {
  function = module.function_main.this.id
}
