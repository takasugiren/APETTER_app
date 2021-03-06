// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

/*global $*/
$(document).on('turbolinks:load', function() {
  $('.back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});

$(document).on('turbolinks:load', function() {
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#sp-menu').fadeToggle();
    event.preventDefault();
  });
});

const typing = (element, sentence) => {
  [...sentence].forEach((character, index) => {
    setTimeout(() => {
      document.querySelector(element).textContent += character;
    }, 100 * ++index);
  });
}

typing('#typing', 'APEX専用のSNSです。');

const typingsub = (element, sentence) => {
  [...sentence].forEach((character, index) => {
    setTimeout(() => {
      document.querySelector(element).textContent += character;
    }, 100 * ++index);
  });
}

typingsub('#typingsub', 'カジュアルやランク、アリーナを一緒にプレイする仲間を見つける事ができるアプリケーションです。');