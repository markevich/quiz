# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.login-form span').addClass('checked').children('input').attr('checked', true);
  
  $('.login-form span').click ->
    if ($(this).children('input').attr('checked'))
      $(this).children('input').attr('checked', false);
      $(this).removeClass('checked');
    else
      $(this).children('input').attr('checked', true);
      $(this).addClass('checked');