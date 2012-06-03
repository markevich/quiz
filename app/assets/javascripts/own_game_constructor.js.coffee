class @OwnGameConstructor
  PRICES_LIMIT=7
  CATEGORIES_LIMIT=6
  PRICES=[10,20,30,50,70,100,150]
  
  @regenerate_grid: ->
    regenerate_grid()
    

  regenerate_grid= ->
    $.post('/quizzes/own_game/constructor',{id: $('#quizzes_id').val()}, (constructor) ->
      $('.questions').html(constructor);
      add_plus_signs()
    )

  create_question= (quiz_id, category, price) ->
    $.post('/questions/own_game/create',
    {quiz_id: quiz_id, category: category, price: price})

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
    return unless categories_count < CATEGORIES_LIMIT
    plus_element = '<div class="category"><div class="name empty"><div class="plus"></div></div></div>'
    $('.category:last').append(plus_element)
    $('.name .plus').click ->
      addCategory()

  addCategory= ->
    name = prompt('Введите название категории.')
    return if (!name? || name == '')
    prices = get_prices()
    for price in prices
      create_question(get_quiz_id(), name, price)
    window.setTimeout(regenerate_grid, 2000)


  addPrice= ->
    prices_count = get_prices().length
    new_price = PRICES[prices_count]
    categories = get_categories()
    for category in categories
      create_question(get_quiz_id(), category, new_price)
    window.setTimeout(regenerate_grid, 2000)


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

  get_quiz_id= ->
    $('#quizzes_id').val()