incrementCommentsCount = (commentableType, commentableId) ->
  $commentCounts = $(".js-comments-count[data-commentable='#{commentableType}-#{commentableId}']")
  nextValue = parseInt($commentCounts.html(), 10) + 1
  $commentCounts.html(nextValue)

decrementCommentsCount = (commentableType, commentableId) ->
  $commentCounts = $(".js-comments-count[data-commentable='#{commentableType}-#{commentableId}']")
  nextValue = parseInt($commentCounts.html(), 10) - 1
  $commentCounts.html(Math.max(nextValue, 0))

$(document).ready ->
  $(".js-comments-form").on "submit", ->
    commentableType = $(@).find("input[name='commentable_type']").val()
    commentableId = $(@).find("input[name='commentable_id']").val()
    incrementCommentsCount(commentableType, commentableId)

  $(".js-comments-form").on "ajax:error", (e, xhr, status, ajaxError) ->
    commentableType = $(@).find("input[name='commentable_type']").val()
    commentableId = $(@).find("input[name='commentable_id']").val()
    decrementCommentsCount(commentableType, commentableId)
