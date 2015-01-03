$(document).ready ->
  $(".js-products-form-new").on "ajax:success", (event, data, status, xhr) ->
    $(@).find("input[name='id']").val(data.product.id).change()
