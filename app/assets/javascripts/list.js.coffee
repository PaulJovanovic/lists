$(document).ready ->
  $(".js-admin-lists-form-new").on "ajax:success", (event, data, status, xhr) ->
    window.location = "/admin/lists/#{data.list.slug}"

  $(".js-lists-form-new").on "ajax:success", (event, data, status, xhr) ->
    window.location = "/lists/#{data.list.slug}"

  $(".js-lists-form-add-product").on "ajax:success", (event, data, status, xhr) ->
    window.location.reload()

  $(".js-list-items-like").on "ajax:success", (event, data, status, xhr) ->
    $(".js-list-form").submit()

  $(".js-list-form").on "ajax:success", (event, data, status, xhr) ->
    list = data.list
    $items = $(".js-list-item").detach()
    ordered_list_ids = (item.id for item in list.items)
    $items.sort (a, b) ->
      ordered_list_ids.indexOf($(a).data("id")) > ordered_list_ids.indexOf($(b).data("id"))
    for item in list.items
      $item = $($items.shift())
      $item.find(".js-list-item-rank").html(item.rank + 1)
      $(".js-list-items").append($item)

  $(".js-lists-form-products-search").on "ajax:success", (event, data, status, xhr) ->
    $results = $($(@).data("results"))
    html = ""
    for product in data.products
      html += """
        <div class="js-lists-search-item" data-sku="#{product.sku}">
          <div class="row nmhxs">
            <div class="col-sm-3 phxs mtxs">
              <img src="#{product.image_url}" class="img-responsive"/>
            </div>
            <div class="col-sm-9 phxs mtxs">
              <div class="fss fwl">
                #{product.name}
              </div>
              <div class="fss fwl">
                #{product.name}
              </div>
            </div>
          </div>
        </div>
      """
    $results.html(html)

  $("body").on "click", ".js-lists-search-item", ->
    $(".js-products-form-new").find("input[name='sku']").val($(@).data("sku")).change()
