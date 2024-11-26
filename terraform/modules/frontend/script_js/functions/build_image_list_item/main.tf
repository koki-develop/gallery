data "js_function" "main" {
  name   = "buildImageListItem"
  params = [data.js_function_param.image.id]
  body = [
    data.js_const.image_list_item.statement,
    data.js_const.size.statement,
    data.js_operation.set_img_src.statement,
    data.js_operation.set_img_width.statement,
    data.js_operation.set_img_height.statement,
    data.js_function_call.image_list_item_add_event_listener.statement,
    data.js_return.main.statement,
  ]
}

data "js_function_param" "image" {
  name = "image"
}

data "js_const" "image_list_item" {
  name  = "imageListItem"
  value = data.js_function_call.image_list_item_template_content_clone_node.expression
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
  value = data.js_function_call.calc_thumb_size.expression
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
  ref   = data.js_function_call.image_list_item_query_selector.expression
  value = "src"
}

data "js_operation" "set_img_src" {
  left     = data.js_index.image_list_item_src.expression
  operator = "="
  right    = data.js_raw.img_src.content
}

data "js_raw" "img_src" {
  value = "`https://picsum.photos/id/$${image.id}/$${size.width}/$${size.height}`"
}

data "js_index" "image_list_item_width" {
  ref   = data.js_function_call.image_list_item_query_selector.expression
  value = "width"
}

data "js_operation" "set_img_width" {
  left     = data.js_index.image_list_item_width.expression
  operator = "="
  right    = data.js_index.width.expression
}

data "js_index" "image_list_item_height" {
  ref   = data.js_function_call.image_list_item_query_selector.expression
  value = "height"
}

data "js_operation" "set_img_height" {
  left     = data.js_index.image_list_item_height.expression
  operator = "="
  right    = data.js_index.height.expression
}

data "js_function_call" "image_list_item_add_event_listener" {
  caller   = data.js_function_call.image_list_item_query_selector.expression
  function = "addEventListener"
  args     = ["click", data.js_function.show_modal.expression]
}

data "js_function" "show_modal" {
  body = [
    data.js_const.modal_image.statement,
    data.js_operation.empty_modal_inner_html.statement,
    data.js_function_call.modal_append_child.statement,
    data.js_function_call.modal_show_modal.statement,
  ]
}

data "js_const" "modal_image" {
  name  = "modalImage"
  value = data.js_function_call.build_modal_image.expression
}

data "js_function_call" "build_modal_image" {
  function = var.function_build_modal_image_id
  args     = [data.js_index.image_download_url.expression]
}

data "js_index" "image_download_url" {
  ref   = data.js_function_param.image.id
  value = "download_url"
}

data "js_operation" "empty_modal_inner_html" {
  left     = data.js_index.modal_inner_html.expression
  operator = "="
  right    = ""
}

data "js_index" "modal_inner_html" {
  ref   = var.const_modal_id
  value = "innerHTML"
}

data "js_function_call" "modal_append_child" {
  caller   = var.const_modal_id
  function = "appendChild"
  args     = [data.js_const.modal_image.id]
}

data "js_function_call" "modal_show_modal" {
  caller   = var.const_modal_id
  function = "showModal"
}

data "js_return" "main" {
  value = data.js_const.image_list_item.id
}
