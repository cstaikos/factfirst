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


  var commentCount = $("#comment-count").text()

  $("#comments").on('click', function(e) {
    e.preventDefault();
    var commentList = $("#comment-list");

    if(commentList.hasClass('nodisplay')) {
      commentList.removeClass('nodisplay');
      $("#comment-show").text('Hide Comments ' + commentCount);
    } else {
      commentList.addClass('nodisplay');
      $("#comment-show").text('Show Comments ' + commentCount);
    }
  });

});
