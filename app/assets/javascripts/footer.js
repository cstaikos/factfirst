$(document).on('ready', function(){
    var formHeight = $('.form-wrapper').height();
    var textWrapHeight = $('.text-wrapper').height();

    //Accounts for pages with very little content
    if(textWrapHeight < 800){
        $('.text-wrapper').css('height', '90vh');
    }

    //Handles the special case of nested forms on the add fact page
    $('.links').on('click', function(){

        formHeight = $('.form-wrapper').height();
        textWrapHeight = $('.text-wrapper').height();

        if ( formHeight > 500){
            $('.text-wrapper').css('height', '');
        } else if (textWrapHeight < 800 && formHeight < 900) {
            //$('.text-wrapper').css('height', '90vh');
        }

    });

});

