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
    for item in list.items
      $item = $(".js-list-item[data-id='#{item.id}']").detach()
      $item.find(".js-list-item-rank").html(item.rank + 1)
      $(".js-list-items").append($item)

  $(".js-lists-form-products-search").on "ajax:success", (event, data, status, xhr) ->
    $results = $($(@).data("results"))
    html = ""
    for product in data.products
      html += """
        <div class="mtxs ptxs bss bwts bc-13 pointer js-lists-search-item" data-sku="#{product.sku}">
          <div class="row nmhxs">
            <div class="col-xs-3 phxs mtxs">
              <img src="#{product.image_url}" class="img-responsive"/>
            </div>
            <div class="col-xs-9 phxs mtxs">
              <div class="fsxs fwl">
                #{product.name}
              </div>
              <div class="fsxs fws">
                #{product.manufacturer}
              </div>
              <div class="fsxs fws">
                $#{Math.round(product.price)}
              </div>
            </div>
          </div>
        </div>
      """
    $results.html(html)

  if $(".js-lists-results").length
    $template = $(".js-list:first").clone()
    $(".js-lists-form-scope").on "ajax:before", ->
      $(".js-lists-results").addClass("fade-m")

    $(".js-lists-form-scope").on "ajax:success", (event, data, status, xhr) ->
      $(".js-lists-results").html("")
      for list in data.lists
        $list = $template.clone()
        $list.find(".js-list-name").html(list.name)
        $list.find(".js-list-url").attr("href", list.url)
        $list.find(".js-list-image").attr("src", list.image)
        $list.find(".js-list-products-count").html("#{list.products_count} #{if list.products_count == 1 then "Product" else "Products"}")
        minimum_price = Math.round(list.minimum_price)
        maximum_price = Math.round(list.maximum_price)
        $list.find(".js-list-minimum-price").html("$#{minimum_price}")
        $list.find(".js-list-maximum-price").html("$#{maximum_price}")
        if minimum_price == maximum_price
          $list.find(".js-list-price-range").addClass("hide")
        else
          $list.find(".js-list-price-range").removeClass("hide")
        $(".js-lists-results").append($list)
    $(".js-lists-form-scope").on "ajax:complete", (event, xhr, status) ->
      $(".js-lists-results").removeClass("fade-m")

  $("body").on "click", ".js-lists-search-item", ->
    $(".js-products-form-new").find("input[name='sku']").val($(@).data("sku")).change()
    $("#addProductModal").modal("hide")
