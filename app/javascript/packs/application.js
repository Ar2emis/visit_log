import "bootstrap";
import "jquery";
import "../stylesheets/application";
import '@client-side-validations/simple-form';
import '@client-side-validations/simple-form/dist/simple-form.bootstrap4';
import '@fortawesome/fontawesome-free/js/all';
import "chartkick";
import "chart.js";
 
document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()
})

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import flatpickr from "flatpickr"

document.addEventListener("turbolinks:load", () => {
  flatpickr("[data-behavior='flatpickr']", {
    altInput: true,
    altFormat: "F j, Y, H:i",
    enableTime: true,
    dateFormat: "Z",
    minDate: "today",
    time_24hr: true
  })
})

import $ from 'jquery';
global.$ = jQuery;
