$(document).on('ready page:load', function(){


    $('#flash-messages').delay(5000).fadeOut(400);

    $('#flash-messages').on('click', function(e) {
    e.preventDefault();
    $( this ).remove();
  });

    var path = window.location.pathname

    if (path === '/'){
        $('#flash-messages').css({
            top: 5,
            width: '35%',
            left: 0,
            right: 0,
            marginLeft: 'auto',
            marginRight: 'auto',
        })

    }
});
