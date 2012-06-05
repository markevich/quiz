class @OwnGame
  @create_teams: ->
    @red_score = 0
    @blue_score = 0
  @get_red_score: ->
    @red_score
  @get_blue_score: ->
    @blue_score
  @regenerate_grid: ->
    regenerate_grid()
    set_default_title()
  @update_teams_score: ->
    @blue_score += extract_answer($('input[name=blue]:checked').val())
    @red_score += extract_answer($('input[name=red]:checked').val())
    $('#counter-left .val').text(@red_score)
    $('#counter-right .val').text(@blue_score)
    reset_answers()
    revert_to_default_title()
    hide_answers()
    show_grid()

  set_default_title= ->
    @title = $('.title .text').text()
  set_title= (value)->
    $('.title .text').text(value)
  revert_to_default_title= ->
    $('.title .text').text(@title)
  extract_answer= (val)->
    price = parseInt($('#price').val())
    switch val
      when 'hz'
        0
      when 'y'
        price
      when 'n'
        -price
  regenerate_grid= ->
    $.post('/quizzes/own_game/constructor',{id: get_quiz_id(), type: 'grid'}, (constructor) ->
      $('.questions').html(constructor)
      $.each($('.item.green'), (index, element)->
        $(element).click ->
          load_question($(this).attr('id'))
          $(this).css("visibility", "hidden")
          hide_grid()
          show_answers()
      ))

  load_question= (id)->
    $.post('/questions/get', {id: id}, (data) ->
      fill_question_fields(data))

  fill_question_fields= (data)->
    $('.qtext').text(data.text)
    $('#price').val(data.params.price)
    set_title(data.params.category+' за '+ data.params.price)

  hide_grid= ->
    $('.questions').hide()
  show_grid= ->
    $('.questions').show()
  reset_answers= ->
    $('input[name=blue]:first').attr('checked', 'checked')
    $('input[name=red]:first').attr('checked', 'checked')
  show_answers= ->
    $('.question').show()
  hide_answers= ->
    $('.question').hide()

  get_quiz_id= ->
    $('#quizzes_id').val()