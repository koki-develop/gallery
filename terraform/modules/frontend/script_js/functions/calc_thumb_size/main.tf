data "js_function" "main" {
  name   = "calcThumbSize"
  params = [data.js_function_param.image.id]
  body = [
    data.js_const.max_size.content,
    data.js_const.aspect_ratio.content,
    data.js_const.thumb_width.content,
    data.js_const.thumb_height.content,
    data.js_return.main.content,
  ]
}

data "js_function_param" "image" {
  name = "image"
}

data "js_const" "max_size" {
  name  = "maxSize"
  value = 400
}

data "js_const" "aspect_ratio" {
  name  = "aspectRatio"
  value = data.js_operation.width_div_height.content
}

data "js_operation" "width_div_height" {
  left     = data.js_index.image_width.id
  operator = "/"
  right    = data.js_index.image_height.id
}

data "js_index" "image_width" {
  ref   = data.js_function_param.image.id
  value = "width"
}

data "js_index" "image_height" {
  ref   = data.js_function_param.image.id
  value = "height"
}

data "js_operation" "aspect_ratio_ge_1" {
  left     = data.js_const.aspect_ratio.id
  operator = ">="
  right    = 1
}

data "js_const" "thumb_width" {
  name  = "thumbWidth"
  value = data.js_conditional_operation.thumb_width.content
}

data "js_conditional_operation" "thumb_width" {
  condition = data.js_operation.aspect_ratio_ge_1.content
  if_true   = data.js_const.max_size.id
  if_false  = data.js_function_call.floor_max_size_times_aspect_ratio.content
}

data "js_function_call" "floor_max_size_times_aspect_ratio" {
  caller   = "Math"
  function = "floor"
  args     = [data.js_operation.max_size_times_aspect_ratio.content]
}

data "js_operation" "max_size_times_aspect_ratio" {
  left     = data.js_const.max_size.id
  operator = "*"
  right    = data.js_const.aspect_ratio.id
}

data "js_const" "thumb_height" {
  name  = "thumbHeight"
  value = data.js_conditional_operation.thumb_height.content
}

data "js_conditional_operation" "thumb_height" {
  condition = data.js_operation.aspect_ratio_ge_1.content
  if_true   = data.js_function_call.floor_max_size_div_aspect_ratio.content
  if_false  = data.js_const.max_size.id
}

data "js_function_call" "floor_max_size_div_aspect_ratio" {
  caller   = "Math"
  function = "floor"
  args     = [data.js_operation.max_size_div_aspect_ratio.content]
}

data "js_operation" "max_size_div_aspect_ratio" {
  left     = data.js_const.max_size.id
  operator = "/"
  right    = data.js_const.aspect_ratio.id
}

data "js_return" "main" {
  value = {
    width  = data.js_const.thumb_width.id,
    height = data.js_const.thumb_height.id,
  }
}
