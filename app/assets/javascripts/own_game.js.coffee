class @OwnGame
  @initialize:() ->
    $('.category .item').live 'click', ->
      category = $(this).siblings('.name').text().trim()
      price = $(this).text().trim()
      quiz_id = $('#quizzes_id').val()
      window.location = '/questions/new?quiz_id='+quiz_id+'&category='+category+'&price='+price
  @update:(category, price) ->
