class @OwnGameConstructor
  PRICES_LIMIT=7
  CATEGORIES_LIMIT=6
  
  @regenerate_grid: ->
    regenerate_grid()
    

  regenerate_grid= ->
    $.post('/quizzes/own_game/constructor',{id: get_quiz_id()}, (constructor) ->
      $('.questions').html(constructor)
      add_plus_signs()
      $('.green.item').tooltip({effect: 'slide'})
    )

  @delete_category=(name) ->
    $.post('/questions/own_game/delete_category',{quiz_id: get_quiz_id, category: name}, ->
      regenerate_grid()
    )
  @delete_price=(name) ->
    $.post('/questions/own_game/delete_price',{quiz_id: get_quiz_id, price: name}, ->
      regenerate_grid()
    )
    

  create_questions= (quiz_id, categories, prices) ->
    $.post('/questions/own_game/create',
    {quiz_id: quiz_id, categories: categories, prices: prices},
    regenerate_grid)

  add_plus_signs= ->
    add_plus_to_price()
    add_plus_to_category()

  add_plus_to_price= ->
    prices_count = get_prices().length
    return unless prices_count < PRICES_LIMIT
    plus_element = '<div class = "item plus"></div>'
    $('.prices').append(plus_element)
    $('.item.plus').click ->
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
    create_questions(get_quiz_id(), [name], prices)


  addPrice= ->
    new_price = prompt('Введите цену.')
    return if (!new_price? || new_price == '' || !is_int(parseInt(new_price)))
    categories = get_categories()
    create_questions(get_quiz_id(), categories, [new_price])


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

  is_int= (n)->
   return (typeof n is 'number' && n % 1 == 0)
