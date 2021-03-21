$(function(){
  $('.load-modal-close').click(function(){
    $('.load-modal-wrapper').fadeOut().hide;
  });

  $('.merit').click(function() {
    const $openText = $(this).find('p');
    if($openText.hasClass('open')) { 
      $openText.removeClass('open');
      $openText.slideUp();
    } else {
      $openText.addClass('open'); 
      $openText.slideDown();
    };
  });
});