$(document).on('ready', function(){

    $('.links').on('click', function(){

        var formHeight = $('.form-wrapper').height();
        var textWrapHeight = $('.text-wrapper').height();

        if ( formHeight > 500){
            $('.text-wrapper').css('height', '');
        } else if (textWrapHeight < 800 && formHeight < 900) {
            $('.text-wrapper').css('height', '90vh');
        }

    });

});

