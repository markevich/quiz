$ ->
  accordion_head = $('.accordion > li > a')
  accordion_body = $('.accordion li > .sub-menu')
  accordion_head.click (event)->
    event.preventDefault()
    if ($(this).attr('class') != 'active')
      accordion_body.slideUp('normal')
      $(this).next().stop(true,true).slideToggle('normal')
      accordion_head.removeClass('active')
      $(this).addClass('active')
