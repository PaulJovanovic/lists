$(document).ready ->
  $(".js-user-form-edit").on "ajax:success", (event, data, status, xhr) ->
    window.location = data.user.profile_url
