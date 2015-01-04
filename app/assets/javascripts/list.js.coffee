$(document).ready ->
  $(".js-admin-lists-form-new").on "ajax:success", (event, data, status, xhr) ->
    window.location = "/admin/lists/#{data.list.slug}"

  $(".js-lists-form-new").on "ajax:success", (event, data, status, xhr) ->
    window.location = "/lists/#{data.list.slug}"

  $(".js-list-items-like").on "ajax:success", (event, data, status, xhr) ->
    $(".js-list-form").submit()

  $(".js-list-form").on "ajax:success", (event, data, status, xhr) ->
    list = data.list
    $items = $(".js-list-item").detach()
    ordered_list_ids = (item.id for item in list.items)
    $items.sort (a, b) ->
      ordered_list_ids.indexOf($(a).data("id")) > ordered_list_ids.indexOf($(b).data("id"))
    $items.each ->
      $(".js-list-items").append($(@))
