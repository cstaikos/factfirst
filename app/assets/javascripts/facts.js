$(document).on('ready page:load', function(){

  window.setTimeout(function() {
    $(".odometer").text($("#actual-score").text());
  }, 10)


  $('#reset').on('click', function() {
    $("#search-index").val("");
  })

  // Grab current filter params
  currentCategory = $('.category-buttons').attr('data-selected');
  currentSort = $('.filter-buttons').attr('data-selected');

  // Trigger search filter while typing
  $("#search-index").on('input', function() {
    if ($(this).val().length > 1 || $(this).val().length === 0) {
      $.ajax({
        url: '/facts?category=' + currentCategory + '&sort=' + currentSort + '&query=' + encodeURIComponent( $(this).val() ),
        dataType: 'script'
      });
    }
  });

});
