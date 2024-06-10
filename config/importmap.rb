# Pin npm packages by running ./bin/importmap
pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@rails/ujs", to: "https://cdn.skypack.dev/@rails/ujs"
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers", preload: true

pin "ckeditor", to: "ckeditor/ckeditor.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "trix_custom_config", to: "trix/trix_custom_config.js"
pin "trix_custom_toolbar", to: "trix/trix_custom_toolbar.js"
