data "js_function_call" "main" {
  caller   = "document"
  function = "querySelector"
  args     = [var.selector]
}
