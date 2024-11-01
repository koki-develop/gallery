#
# function saveImage(key, body, contentType)
#

data "js_function" "main" {
  async = true
  name  = "saveImage"
  params = [
    data.js_function_param.key.id,
    data.js_function_param.body.id,
    data.js_function_param.contentType.id,
  ]
  body = [
    data.js_const.command.content,
    data.js_await.send.content,
  ]
}

data "js_function_param" "key" {
  name = "key"
}

data "js_function_param" "body" {
  name = "body"
}

data "js_function_param" "contentType" {
  name = "contentType"
}

#
# const command = new PutObjectCommand(input)
#

data "js_new" "put_object_command" {
  constructor = "PutObjectCommand"
  args = [{
    Bucket      = "${var.name}-images"
    Key         = data.js_function_param.key.id
    Body        = data.js_function_param.body.id
    ContentType = data.js_function_param.contentType.id
  }]
}

data "js_const" "command" {
  name  = "command"
  value = data.js_new.put_object_command.content
}

#
# await s3Client.send(command)
#

data "js_function_call" "send" {
  caller   = var.s3_client_id
  function = "send"
  args     = [data.js_const.command.id]
}

data "js_await" "send" {
  value = data.js_function_call.send.content
}
