// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "bootstrap";
import "../stylesheets/application.scss";

//= require rails-ujs
//= require activestorage
//= require turbolinks 
//= require jquery
//= require_tree .

$(function() {
  return $('#customer_postcode').jpostal({
    postcode: ['#customer_postcode'],
    address: {
      '#customer_prefecture_code': '%3',
      '#customer_address_city': '%4',
      '#customer_address_street': '%5%6%7'
    },
  });
});

// https://zenn.dev/necocoa/articles/rails-stimulus-tr-link参照
import "controllers"