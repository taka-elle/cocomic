$(function(){
  $('.load-modal-close').click(function(){
    $('.load-modal-wrapper').fadeOut().hide;
  });

  $('.top-modal-menu').click(function(){
    const $openMenu = $(this).find('.top-modal-menu-list')
    if($openMenu.hasClass('open')) { 
      $openMenu.animate( { width: 'toggle' }, 'slow' );
      $(".modal-menu").slideUp('slow');
      $openMenu.removeClass('open');
    } else {
      $openMenu.animate( { width: 'toggle' }, 'slow' );
      $(".modal-menu").slideDown('slow');
      $openMenu.addClass('open'); 
    };
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