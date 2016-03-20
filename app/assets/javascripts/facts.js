$(document).on('ready page:load', function(){

  // Truncate text on fact-show padding-left
  $(".evidence-title").dotdotdot({
      });

  $(".evidence-description").dotdotdot({
      });

  $(".tooltip-item").dotdotdot({
      });

  // Odomoter (number scrolling) on fact show page
  window.setTimeout(function() {
    $(".odometer").text($("#actual-score").text());
  }, 10)


  // Trigger category dropdown
  $("#category-dropdown-trigger").on('click', function(){
    categoryMenu = $('.category-buttons .button-group');
    if (categoryMenu.css('display') == 'none') {
      categoryMenu.show(400);
    }
    else {
      categoryMenu.hide(400);
    }
  });

  // Trigger sort dropdown
  $("#sort-dropdown-trigger").on('click', function(){
    categoryMenu = $('.filter-buttons .button-group');
    if (categoryMenu.css('display') == 'none') {
      categoryMenu.show(400);
    }
    else {
      categoryMenu.hide(400);
    }
  });


  // Reset search box when clicking reset
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
        dataType: 'script',
        beforeSend: function(){
            $('#spinner').show().css({display: 'block'});
            $('#facts-list').empty();
        },
        complete: function(){
            $('#spinner').hide();
        }
      });
    }
  });

  // Bind spinner events to category/sort buttons as well
  $('.category-buttons form, .filter-buttons form').bind('ajax:beforeSend', function() {
    $('#spinner').show().css({display: 'block'});
  })

  $('.category-buttons form, .filter-buttons form').bind('ajax:complete', function() {
    $('#spinner').hide();
  })

});
