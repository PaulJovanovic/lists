$(document).ready ->
  $(".js-admin-lists-form-new").on "ajax:success", (event, data, status, xhr) ->
    window.location = "/admin/lists/#{data.list.slug}"

  $(".js-lists-form-new").on "ajax:success", (event, data, status, xhr) ->
    window.location = "/lists/#{data.list.slug}"
