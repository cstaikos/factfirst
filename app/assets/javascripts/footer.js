$(document).on('ready', function(){


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

muut(function() {
  var formHeight = $('.form-wrapper').height();
  var textWrapHeight = $('.application-wrapper').height();

  //Accounts for pages with very little content
  if(textWrapHeight < 800){
      $('.application-wrapper').css('height', '90vh');
  }
});
