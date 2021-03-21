$(function(){
  $('.ticket-modal-open').click(function(){
    $('.ticket-modal-wrapper').fadeIn();
  });
  $('.load-modal-close').click(function(){
    $('.ticket-modal-wrapper').fadeOut().hide;
  });
});