$(document).ready ->
  $("body").on "click", ".js-tab", (e) ->
    e.preventDefault()
    $activeTab = $(".js-tab[data-group='#{$(@).data("group")}']")
    $activeTab.removeClass("active")
    $(@).addClass("active")

  $("img.lazy").lazyload
    threshold: 400
