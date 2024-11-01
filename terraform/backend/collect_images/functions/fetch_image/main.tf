#
# function fetchImage(id, width, height)
#

data "js_function" "main" {
  async = true
  name  = "fetchImage"
  params = [
    data.js_function_param.id.id,
    data.js_function_param.width.id,
    data.js_function_param.height.id,
  ]
  body = [
    data.js_const.url.content,
    data.js_const.response.content,
    data.js_if.not_response_ok.content,
    data.js_const.content_type.content,
    data.js_const.buffer.content,
    data.js_const.body.content,
    data.js_return.image.content,
  ]
}

data "js_function_param" "id" {
  name = "id"
}

data "js_function_param" "width" {
  name = "width"
}

data "js_function_param" "height" {
  name = "height"
}

#
# const url = `https://picsum.photos/id/${id}/${Math.floor(width)}/${Math.floor(height)}`;
#

data "js_const" "url" {
  name  = "url"
  value = data.js_raw.url.content
}

data "js_raw" "url" {
  value = "`https://picsum.photos/id/$${id}/$${Math.floor(width)}/$${Math.floor(height)}`"
}

#
# const response = await fetch(url);
#

data "js_const" "response" {
  name  = "response"
  value = data.js_await.fetch.content
}

data "js_await" "fetch" {
  value = data.js_function_call.fetch.content
}

data "js_function_call" "fetch" {
  function = "fetch"
  args     = [data.js_const.url.id]
}

#
# if (!response.ok)
#

data "js_if" "not_response_ok" {
  condition = data.js_raw.not_response_ok.content
  then      = [data.js_throw.error.content]
}

data "js_raw" "not_response_ok" {
  value = "!response.ok"
}

#
# throw new Error(`Failed to fetch image: ${response.status}`);
#

data "js_throw" "error" {
  value = data.js_new.error.content
}

data "js_new" "error" {
  constructor = "Error"
  args        = [data.js_raw.error_message.content]
}

data "js_raw" "error_message" {
  value = "`Failed to fetch image: $${response.status}`"
}

#
# const contentType = response.headers.get('content-type');
#

data "js_const" "content_type" {
  name  = "contentType"
  value = data.js_function_call.get_content_type.content
}

data "js_function_call" "get_content_type" {
  caller   = data.js_index.response_headers.id
  function = "get"
  args     = ["content-type"]
}

data "js_index" "response_headers" {
  ref   = data.js_const.response.id
  value = "headers"
}

#
# const buffer = await response.arrayBuffer();
#

data "js_const" "buffer" {
  name  = "buffer"
  value = data.js_await.array_buffer.content
}

data "js_await" "array_buffer" {
  value = data.js_function_call.array_buffer.content
}

data "js_function_call" "array_buffer" {
  function = "arrayBuffer"
  caller   = data.js_const.response.id
}

#
# const body = new Uint8Array(buffer);
#

data "js_const" "body" {
  name  = "body"
  value = data.js_new.uint8_array.content
}

data "js_new" "uint8_array" {
  constructor = "Uint8Array"
  args        = [data.js_const.buffer.id]
}

#
# return { contentType, body }
#

data "js_return" "image" {
  value = {
    contentType = data.js_const.content_type.id,
    body        = data.js_const.body.id,
  }
}
