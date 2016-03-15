$(document).on('ready page:load', function(){

  window.setTimeout(function() {
    $(".odometer").text($("#actual-score").text());
  }, 10)


  $("#search-index").on('keyup', function() {
    if ($(this).val().length > 1) {
      $.ajax({
        url: '/facts?query=' + encodeURIComponent( $(this).val() ),
        dataType: 'script'
      });
    }
  });



});
