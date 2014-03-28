$(document).ready(function() {
  $('#posts .blog-post img').addClass('center-block img-thumbnail');

  $(".carousel").swiperight(function() {
    $(this).carousel('prev');
  });

  $(".carousel").swipeleft(function() {
    $(this).carousel('next');
  });

});

$(document).bind('keyup', function(e) {
  if (e.which == 39) {
    $('.carousel').carousel('next');
  } else if (e.which == 37) {
    $('.carousel').carousel('prev');
  }
});
