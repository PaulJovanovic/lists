$(document).ready ->
  $("body").on "click", ->
    $(".js-navbar-dropdown.active").each ->
      $(@).click()

