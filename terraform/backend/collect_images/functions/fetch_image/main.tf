#
# function fetchImage(id, width, height)
#

resource "js_function" "fetch_image" {
  async = true
  name  = "fetchImage"
  body = [
    js_const.url.content,
    js_const.response.content,
    js_if.not_response_ok.content,
    js_const.content_type.content,
    js_const.buffer.content,
    js_const.body.content,
    js_return.image.content,
  ]
}

resource "js_function_param" "id" {
  name = "id"
}

resource "js_function_param" "width" {
  name = "width"
}

resource "js_function_param" "height" {
  name = "height"
}

#
# const url = `https://picsum.photos/id/${id}/${Math.floor(width)}/${Math.floor(height)}`;
#

resource "js_const" "url" {
  name  = "url"
  value = data.js_raw.url.content
}

data "js_raw" "url" {
  value = "`https://picsum.photos/id/$${id}/$${Math.floor(width)}/$${Math.floor(height)}`"
}

#
# const response = await fetch(url);
#

resource "js_const" "response" {
  name  = "response"
  value = js_await.fetch.content
}

resource "js_await" "fetch" {
  value = js_function_call.fetch.content
}

resource "js_function_call" "fetch" {
  function = "fetch"
  args     = [js_const.url.id]
}

#
# if (!response.ok)
#

resource "js_if" "not_response_ok" {
  condition = data.js_raw.not_response_ok.content
  then      = [js_throw.error.content]
}

data "js_raw" "not_response_ok" {
  value = "!response.ok"
}

#
# throw new Error(`Failed to fetch image: ${response.status}`);
#

resource "js_throw" "error" {
  value = js_new.error.content
}

resource "js_new" "error" {
  value = js_function_call.error.content
}

resource "js_function_call" "error" {
  function = "Error"
  args     = [data.js_raw.error_message.content]
}

data "js_raw" "error_message" {
  value = "`Failed to fetch image: $${response.status}`"
}

#
# const contentType = response.headers.get('content-type');
#

resource "js_const" "content_type" {
  name  = "contentType"
  value = js_function_call.get_content_type.content
}

resource "js_function_call" "get_content_type" {
  caller   = data.js_index.response_headers.id
  function = "get"
  args     = ["content-type"]
}

data "js_index" "response_headers" {
  ref   = js_const.response.id
  value = "headers"
}

#
# const buffer = await response.arrayBuffer();
#

resource "js_const" "buffer" {
  name  = "buffer"
  value = js_await.array_buffer.content
}

resource "js_await" "array_buffer" {
  value = js_function_call.array_buffer.content
}

resource "js_function_call" "array_buffer" {
  function = "arrayBuffer"
  caller   = js_const.response.id
}

#
# const body = new Uint8Array(buffer);
#

resource "js_const" "body" {
  name  = "body"
  value = js_new.uint8_array.content
}

resource "js_new" "uint8_array" {
  value = js_function_call.uint8_array.content
}

resource "js_function_call" "uint8_array" {
  function = "Uint8Array"
  args     = [js_const.buffer.id]
}

#
# return { contentType, body }
#

resource "js_return" "image" {
  value = {
    contentType = js_const.content_type.id,
    body        = js_const.body.id,
  }
}
