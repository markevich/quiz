class @OwnGameConstructor
  @PRICES_LIMIT=7
  @CATEGORIES_LIMIT=7
  
  @regenerate_grid: ->
    $.post('/quizzes/own_game/constructor',{id: $('#quizzes_id').val()}, (constructor) ->
      $('.questions').html(constructor);
    )

  @create_question: (quiz_id, category, price) ->
    $.post('/questions/own_game/create',
    {quiz_id: quiz_id, category: category, price: price})

  @addCategory: ->
    categories_count = $('.category').length
    return if categories_count >= @CATEGORIES_LIMIT
    $('.questions').append($('.category:first').clone())

  @addPrice: ->
    prices_count = $('.item', '.category:first').length
    return if prices_count >= @PRICES_LIMIT
    $('.category').each ->
      $(this).append($('.item:first',this).clone())