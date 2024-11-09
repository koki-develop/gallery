data "js_function" "main" {
  name   = "buildImageList"
  params = [data.js_function_param.images.id]
  body = [
    data.js_const.image_list.statement,
    data.js_function_call.images_for_each.statement,
    data.js_return.main.statement,
  ]
}

data "js_function_param" "images" {
  name = "images"
}

data "js_const" "image_list" {
  name  = "imageList"
  value = data.js_function_call.image_list_template_content_clone_node.expression
}

data "js_index" "image_list_template_content" {
  ref   = var.const_image_list_template_id
  value = "content"
}

data "js_function_call" "image_list_template_content_clone_node" {
  caller   = data.js_index.image_list_template_content.id
  function = "cloneNode"
  args     = [true]
}

data "js_function_call" "images_for_each" {
  caller   = data.js_function_param.images.id
  function = "forEach"
  args     = [data.js_function.build_image_list_item.statement]
}

data "js_function" "build_image_list_item" {
  params = [data.js_function_param.image.id]
  body = [
    data.js_const.image_list_item.statement,
    data.js_function_call.image_list_append_child.statement,
  ]
}

data "js_function_param" "image" {
  name = "image"
}

data "js_const" "image_list_item" {
  name  = "imageListItem"
  value = data.js_function_call.build_image_list_item.expression
}

data "js_function_call" "build_image_list_item" {
  function = var.function_build_image_list_item_id
  args     = [data.js_function_param.image.id]
}

data "js_function_call" "image_list_query_selector" {
  caller   = data.js_const.image_list.id
  function = "querySelector"
  args     = ["div"]
}

data "js_function_call" "image_list_append_child" {
  caller   = data.js_function_call.image_list_query_selector.expression
  function = "appendChild"
  args     = [data.js_const.image_list_item.id]
}

data "js_return" "main" {
  value = data.js_const.image_list.id
}
