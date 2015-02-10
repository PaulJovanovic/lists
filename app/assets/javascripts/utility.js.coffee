$(document).ready ->
  $("body").on "click", ".js-tab", (e) ->
    e.preventDefault()
    $activeTab = $(".js-tab[data-group='#{$(@).data("group")}']")
    $activeTab.removeClass("active")
    $(@).addClass("active")

  $("body").on "click", ".js-toggle", (e) ->
    e.preventDefault()
    e.stopPropagation()
    $($(@).data("toggle-target")).toggleClass($(@).data("toggle-class"))
    $(@).toggleClass("active")

  $("img.lazy").lazyload
    threshold: 400

  $('textarea').autosize();
