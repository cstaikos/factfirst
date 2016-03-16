$(document).ready(function() {
    //form id
    $('#new_user')
        .bind('ajax:success', function(evt, data, status, xhr) {
            //function called on status: 200 (for ex.)
            console.log('success');
        })
        .bind("ajax:error", function(evt, xhr, status, error) {
            //function called on status: 401 or 500 (for ex.)
            console.log(xhr.responseText);
            console.log("HEllo!!!");

            $( ".auth-error-messages" ).html( "<span>Invalid Email or Password</span>" );
            $( ".auth-error-messages span" ).delay(5000).fadeOut(400);

        });
});