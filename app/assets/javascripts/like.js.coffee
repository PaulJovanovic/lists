incrementLikesCount = (likableType, likableId) ->
  $likeCounts = $(".js-likes-count[data-likable='#{likableType}-#{likableId}']")
  nextValue = parseInt($likeCounts.html(), 10) + 1
  $likeCounts.html(nextValue)

decrementLikesCount = (likableType, likableId) ->
  $likeCounts = $(".js-likes-count[data-likable='#{likableType}-#{likableId}']")
  nextValue = parseInt($likeCounts.html(), 10) - 1
  $likeCounts.html(Math.max(nextValue, 0))

$(document).ready ->
  $(".js-likes-form-like").on "submit", ->
    $(@).closest(".js-like").addClass("active")
    likableType = $(@).find("input[name='likable_type']").val()
    likableId = $(@).find("input[name='likable_id']").val()
    incrementLikesCount(likableType, likableId)

  $(".js-likes-form-like").on "ajax:error", (e, xhr, status, ajaxError) ->
    $(@).closest(".js-like").removeClass("active")
    likableType = $(@).find("input[name='likable_type']").val()
    likableId = $(@).find("input[name='likable_id']").val()
    decrementLikesCount(likableType, likableId)

  $(".js-likes-form-unlike").on "submit", ->
    $(@).closest(".js-like").removeClass("active")
    likableType = $(@).find("input[name='likable_type']").val()
    likableId = $(@).find("input[name='likable_id']").val()
    decrementLikesCount(likableType, likableId)

  $(".js-likes-form-unlike").on "ajax:error", (e, xhr, status, ajaxError) ->
    $(@).closest(".js-like").addClass("active")
    likableType = $(@).find("input[name='likable_type']").val()
    likableId = $(@).find("input[name='likable_id']").val()
    incrementLikesCount(likableType, likableId)
