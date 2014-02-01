$(function() {
  $('.item').click(function() {
    $('.current').removeClass('current');
    $(this).addClass('current');
  });
});
