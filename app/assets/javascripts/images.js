$(document).ready(function() {
  $('#posts .blog-post img').addClass('center-block img-thumbnail');
});

$(document).bind('keyup', function(e) {
  if (e.which == 39) {
    $('.carousel').carousel('next');
  } else if (e.which == 37) {
    $('.carousel').carousel('prev');
  }
});
