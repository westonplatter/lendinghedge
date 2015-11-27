//= require fe/jquery.min
//= require fe/bootstrap
//= require fe/jquery.easing.1.3.min

$(function() {
  $('.navbar-nav a').bind('click', function(event) {
    var $anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: $($anchor.attr('href')).offset().top - 0
    }, 500, 'easeInOutExpo');
    event.preventDefault();
  });
});
