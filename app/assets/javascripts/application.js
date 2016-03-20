// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require underscore
//= require react
//= require react_ujs
//= require components
//= require_tree .
//= require refills/navigation
//= require flashnotice
//= require odometer.min.js

// NOTE: This is a quick bug fix because the login modal was not opening on different screen sizes when button was hidden
// We should probably fundamentally redo the way we handle the login modal at some point to remove this dependency
$(document).on('ready', function(){
    $('.requires-login').on('click', function(e){
        if ($(this).hasClass('requires-login')) {
          e.preventDefault();
          if (Modernizr.mq('(min-width: 900px)')) {
            $("#modal-trigger-screen").click();
          } else if (Modernizr.mq('(max-width: 900px)')) {
            $("#modal-trigger-mobile").click();
          }
        }
    });

});
