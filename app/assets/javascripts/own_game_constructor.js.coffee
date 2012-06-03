class @OwnGameConstructor
  PRICES_LIMIT=7
  CATEGORIES_LIMIT=6
  PRICES=[10,20,30,50,70,100,150]
  
  @regenerate_grid: ->
    $.post('/quizzes/own_game/constructor',{id: $('#quizzes_id').val()}, (constructor) ->
      $('.questions').html(constructor);
      add_plus_signs()
    )


  create_question= (quiz_id, category, price) ->
    $.post('/questions/own_game/create',
    {quiz_id: quiz_id, category: category, price: price})
    @regenerate_grid()

  add_plus_signs= ->
    add_plus_to_price()
    add_plus_to_category()

  add_plus_to_price= ->
    prices_count = get_prices().length
    return unless prices_count < PRICES_LIMIT
    plus_element = $('.prices .item:first').clone().text('').attr('class', 'item plus')
    $('.prices').append(plus_element)
    plus_element.click ->
      addPrice()

  add_plus_to_category= ->
    categories_count = get_categories().length
    return inless categories_count < CATEGORIES_LIMIT
    plus_element = '<div class="category"><div class="name plus"></div></div>'

  @addCategory: ->

  addPrice= ->
    prices_count = get_prices().length
    price = PRICES[prices_count]
    alert price


  get_categories= ->
    categories = []
    $.each $('.category .name'), (index, element)->
      return if $(element).hasClass('empty')
      categories.push($(element).text())
    categories

  get_prices= ->
    prices = []
    $.each $('.prices .item'), (index, element)->
      return false if $(element).hasClass('plus')
      prices.push($(element).text())
    prices
