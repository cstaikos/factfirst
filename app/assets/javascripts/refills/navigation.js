// Add nice transition into jQuery "hamburger" nav menu
$(document).on("ready page:load", function() {
  var menuToggle = $('#js-mobile-menu').unbind();
  $('#js-navigation-menu').removeClass("show");

  menuToggle.on('click', function(e) {
    e.preventDefault();
    $('#js-navigation-menu').slideToggle(function(){
      if($('#js-navigation-menu').is(':hidden')) {
        $('#js-navigation-menu').removeAttr('style');
      }
    });
  });
});

// Switch nav bars on home page when scrolling gets to a certain point
$(function() {
  $(document).bind('ready page:load scroll', function() {
	   	var docScroll = $(document).scrollTop();
      // This is something we might want for mobile later in the below if statement: & $('html').height() > 768
		  if (docScroll >= 325) {

        if ($('.img-logo').hasClass('nodisplay')) {
          $('.img-logo').removeClass('nodisplay');
        }

        if ($('nav').hasClass('nodisplay')) {
          $('nav').removeClass('nodisplay');
        }

        if (!$('.navigation').hasClass('nav-bg')) {
          $('.navigation').addClass('nav-bg');
        }
	  	} else {
		  	$('.navigation').removeClass('nav-bg');
        if (!$('.img-logo').hasClass('nodisplay')) {
          $('.img-logo').addClass('nodisplay');
        }
        if (!$('nav').hasClass('nodisplay')) {
          $('nav').addClass('nodisplay');
        }
	  	}
    });
});
