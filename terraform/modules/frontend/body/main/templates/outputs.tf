output "html" {
  value = join("", [
    data.html_template.image_list.html,
    data.html_template.image_list_item.html,
    data.html_template.modal_image.html,
  ])
}
