$(document).on('ready page:load', function(){
    //$('#flash-messages').parent().append($('#flash-messages'));
    $('#flash-messages').delay(5000).fadeOut(400);

    $('#flash-messages').on('click', function(e) {
    e.preventDefault();
    $( this ).empty();
  });
});
