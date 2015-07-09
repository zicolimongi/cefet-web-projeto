# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class window.ShopCart
  constructor: ->
    shopcart = JSON.parse(sessionStorage.getItem('shopcart'))
    @products = []
    if shopcart != null
      for data in shopcart
        @addProduct (data)

    $('.cart').on 'click', (e) =>
      @showProductsInCart()

    $(".buy-button").on 'click', (e) =>
      @addProduct $(e.target).data()
      sessionStorage.setItem('shopcart', JSON.stringify(@products))
      $('.cart').removeClass('cart-animation')
      $('.cart').addClass('cart-animation')

  addProduct: (data) ->
    @products.push new Product(data.id, data.name, data.description, data.imageLink, data.price)
    $('.cart-number').html(@products.length)

  showProductsInCart: () ->
    html = ''
    total = 0
    for product in @products
      total += parseInt(product.price)
      html +=  "<div class=\"panel panel-default\">
                  <div class=\"panel-heading\">
                    <h3 class=\"panel-title\">#{product.name}</h3>
                  </div>
                  <div class=\"panel-body product\">
                    <div class=\"col-xs-12 col-md-3\">
                      <img src=\"#{product.imageLink}\" class=\"img-circle\">
                    </div>
                    <div class=\"col-xs-12 col-md-9\">
                      <p class=\"lead\">#{product.description}</p>
                      <p class=\"text-center price\">#{product.price}</p>
                    </div>
                  </div>
                </div>"

    html += "<div class=\"panel panel-success\">
              <div class=\"panel-heading\">
                <h3 class=\"panel-title\">Total: #{total}</h3>
              </div>
              <div class=\"panel-body product\">
                <div class=\"col-xs-12 col-md-9\">
                  <p class=\"lead\">Você pode fazer seu pagamento utilizando o cartão de débito ou crédio e ou imprimir o boleto bancário</p>
                </div>
                <div class=\"col-xs-12 col-md-3\">
                  <button class=\"btn btn-lg btn-success\">Realizar pagamento</button>
                </div>
              </div>
            </div>"

    $('.container').html(html)



class window.Product
  constructor: (@id, @name, @description, @imageLink, @price) ->
