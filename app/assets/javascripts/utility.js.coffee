$(document).ready ->
  $("body").on "click", ".js-tab", (e) ->
    e.preventDefault()
    $activeTab = $(".js-tab[data-tab-group='#{$(@).data("tab-group")}'].active")
    $($activeTab.data("tab-target")).removeClass("active")
    $activeTab.removeClass("active")
    console.log($activeTab)
    $(@).addClass("active")
    $($(@).data("tab-target")).addClass("active")

  $("body").on "click", ".js-toggle", (e) ->
    e.preventDefault()
    e.stopPropagation()
    $($(@).data("toggle-target")).toggleClass($(@).data("toggle-class"))
    $(@).toggleClass("active")

  $("img.lazy").lazyload
    threshold: 400

  $('textarea').autosize();
