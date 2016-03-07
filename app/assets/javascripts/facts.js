$(document).on('ready page:load', function(){

  $("#search").on('keydown', function() {
    if ($(this).val().length > 1) {
      $.ajax({
        url: '/facts?query=' + encodeURIComponent( $(this).val() ),
        dataType: 'script'
      });
    }
  });


});
