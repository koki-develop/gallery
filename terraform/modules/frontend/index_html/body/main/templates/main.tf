data "html_template" "image_list" {
  id       = "image-list-template"
  children = [data.html_div.image_list.html]
}

data "html_div" "image_list" {
  class    = "columns-2 sm:columns-3 lg:columns-4 gap-x-4"
  children = []
}

data "html_template" "image_list_item" {
  id       = "image-list-item-template"
  children = [data.html_img.image_list_item.html]
}

data "html_img" "image_list_item" {
  class = "cursor-pointer w-full mb-4 rounded hover:scale-105 shadow hover:shadow-lg transition"
  alt   = ""
}

data "html_template" "modal_image" {
  id       = "modal-image-template"
  children = [data.html_img.modal_image.html, data.html_div.modal_image_loader.html]
}

data "html_img" "modal_image" {
  class = "max-h-[80dvh] max-w-[80dvw] object-contain"
  alt   = ""
}

data "html_div" "modal_image_loader" {
  id       = "modal-image-loader"
  class    = "loader dark"
  children = []
}
