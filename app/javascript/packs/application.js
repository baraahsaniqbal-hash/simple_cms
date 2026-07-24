// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "bootstrap"
import "bootstrap/dist/css/bootstrap.css"

import $ from "jquery";
import jQuery from "jquery"
window.$ = $;
window.jQuery = jQuery;

// Add these two lines for Select2
import "select2"
import "select2/dist/css/select2.css"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Initialize Select2 with Turbolinks support
$(document).on('turbolinks:load', function() {
  $(".select2,.select2-enable").select2();
});