data "html_head" "main" {
  children = [
    data.html_meta.charset.html,
    data.html_meta.viewport.html,
    data.html_title.main.html,
    data.html_script.tailwind.html,
    data.html_style.main.html,
  ]
}

data "html_meta" "charset" {
  charset = "UTF-8"
}

data "html_meta" "viewport" {
  name    = "viewport"
  content = "width=device-width, initial-scale=1.0"
}

data "html_title" "main" {
  children = ["Gallery"]
}

data "html_script" "tailwind" {
  src      = "https://cdn.tailwindcss.com"
  children = []
}

data "html_style" "main" {
  children = [
    <<-EOF
    .loader {
      width: 48px;
      height: 48px;
      border: 5px solid;
      border-radius: 50%;
      display: inline-block;
      box-sizing: border-box;
      animation: rotation 1s linear infinite;
    }

    @keyframes rotation {
      0% {
          transform: rotate(0deg);
      }
      100% {
          transform: rotate(360deg);
      }
    }

    .loader.light {
      border-color: dimgray;
      border-bottom-color: transparent;
    }

    .loader.dark {
      border-color: white;
      border-bottom-color: transparent;
    }
    EOF
  ]
}
