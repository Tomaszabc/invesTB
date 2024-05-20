// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import CKEditor from "ckeditor"

window.Stimulus = Application.start()
const context = require.context("controllers", true, /\.js$/)
Stimulus.load(definitionsFromContext(context))