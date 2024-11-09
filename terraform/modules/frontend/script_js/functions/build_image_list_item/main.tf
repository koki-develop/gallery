data "js_function" "main" {
  name   = "buildImageListItem"
  params = [data.js_function_param.image.id]
  body = [
    data.js_const.image_list_item.content,
    data.js_const.size.content,
    data.js_operation.set_img_src.content,
    data.js_operation.set_img_width.content,
    data.js_operation.set_img_height.content,
    data.js_return.main.content,
  ]
}

data "js_function_param" "image" {
  name = "image"
}

data "js_const" "image_list_item" {
  name  = "imageListItem"
  value = data.js_function_call.image_list_item_template_content_clone_node.content
}

data "js_index" "image_list_item_template_content" {
  ref   = var.const_image_list_item_template_id
  value = "content"
}

data "js_function_call" "image_list_item_template_content_clone_node" {
  caller   = data.js_index.image_list_item_template_content.id
  function = "cloneNode"
  args     = [true]
}

data "js_const" "size" {
  name  = "size"
  value = data.js_function_call.calc_thumb_size.content
}

data "js_index" "width" {
  ref   = data.js_const.size.id
  value = "width"
}

data "js_index" "height" {
  ref   = data.js_const.size.id
  value = "height"
}

data "js_function_call" "calc_thumb_size" {
  function = var.function_calc_thumb_size_id
  args     = [data.js_function_param.image.id]
}

data "js_function_call" "image_list_item_query_selector" {
  caller   = data.js_const.image_list_item.id
  function = "querySelector"
  args     = ["img"]
}

data "js_index" "image_list_item_src" {
  ref   = data.js_function_call.image_list_item_query_selector.content
  value = "src"
}

data "js_operation" "set_img_src" {
  left     = data.js_index.image_list_item_src.content
  operator = "="
  right    = data.js_raw.img_src.content
}

data "js_raw" "img_src" {
  value = "`https://picsum.photos/id/$${image.id}/$${size.width}/$${size.height}`"
}

data "js_index" "image_list_item_width" {
  ref   = data.js_function_call.image_list_item_query_selector.content
  value = "width"
}

data "js_operation" "set_img_width" {
  left     = data.js_index.image_list_item_width.content
  operator = "="
  right    = data.js_index.width.content
}

data "js_index" "image_list_item_height" {
  ref   = data.js_function_call.image_list_item_query_selector.content
  value = "height"
}

data "js_operation" "set_img_height" {
  left     = data.js_index.image_list_item_height.content
  operator = "="
  right    = data.js_index.height.content
}

data "js_return" "main" {
  value = data.js_const.image_list_item.id
}
