$(function(){
  $('.login-name').click(function() {
    const $openText = $(".header-content").find('.name-lists');
    if($openText.hasClass('open')) { 
      $openText.removeClass('open');
      $openText.slideUp();
    } else {
      $openText.addClass('open'); 
      $openText.slideDown();
    };
  });
});