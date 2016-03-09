$(document).on('ready page:load', function(){

  $("#search").on('keydown', function() {
    if ($(this).val().length > 1) {
      $.ajax({
        url: '/facts?query=' + encodeURIComponent( $(this).val() ),
        dataType: 'script'
      });
    }
  });

  $("#comments").on('click', function(e) {
    e.preventDefault();
    var commentList = $("#comment-list");

    if(commentList.hasClass('nodisplay')) {
      commentList.removeClass('nodisplay');
    } else {
      commentList.addClass('nodisplay');
    }
  });

});
