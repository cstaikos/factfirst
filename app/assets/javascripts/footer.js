var fixFooterHeight = function() {
  var formHeight = $('.form-wrapper').height();
  var textWrapHeight = $('.application-wrapper').height();

  //Accounts for pages with very little content
  if(textWrapHeight < 800){
      $('.application-wrapper').css('height', '90vh');
  }
}

$(document).on('ready', function(){

    // If no muut forum, fix footer height on doc ready
    if (typeof muut == "undefined") {
      fixFooterHeight();
    }
    //Handles the special case of nested forms on the add fact page
    $('.links').on('click', function(){

        formHeight = $('.form-wrapper').height();
        textWrapHeight = $('.application-wrapper').height();

        if ( formHeight > 500){
            $('.application-wrapper').css('height', '');
        } else if (textWrapHeight < 800 && formHeight < 900) {
            //$('.application-wrapper').css('height', '90vh');
        }

    });

});

// If muut forum is on page, wait til it's done loading before setting footer height
if (typeof muut != "undefined") {
  muut(function() {
    fixFooterHeight();
  });
}
