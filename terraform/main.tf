module "frontend_index_html" {
  source = "./modules/frontend/index_html"
}

module "frontend_script_js" {
  source       = "./modules/frontend/script_js"
  api_base_url = module.infrastructure.api_base_url
}

module "backend_get_images_js" {
  source = "./modules/backend/get_images"
}

module "infrastructure" {
  source                    = "./modules/infrastructure"
  name                      = "koki-gallery"
  domain                    = "tftftf.gallery"
  index_html_content        = module.frontend_index_html.content
  script_js_content         = module.frontend_script_js.content
  api_get_images_js_content = module.backend_get_images_js.content
}
