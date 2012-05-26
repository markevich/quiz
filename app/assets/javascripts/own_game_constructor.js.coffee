class @OwnGameConstructor
  @PRICES_LIMIT=7
  @CATEGORIES_LIMIT=7
    
  @addCategory: ->
    categories_count = $('.category').length
    return if categories_count >= @CATEGORIES_LIMIT
    $('.questions').append($('.category:first').clone())

  @addPrice: ->
    prices_count = $('.item', '.category:first').length
    return if prices_count >= @PRICES_LIMIT
    $('.category').each ->
      $(this).append($('.item:first',this).clone())