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

$(function() {
  $(document).bind('ready page:load scroll', function() {
	   	var docScroll = $(document).scrollTop();
		  if (docScroll >= 100 & $('html').height() > 768) {
			  if (!$('body').hasClass('sticky')) {
				  $('body').addClass('sticky');
  			}
	  	} else {
		  	$('body').removeClass('sticky');
		  	$('.site-nav').removeAttr('style');
	  	}
    });
});
