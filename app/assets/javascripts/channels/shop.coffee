$(document).on 'turbolinks:load', ->
  if $('.shops.show').length == 1
    slug = $('[data-slug]').data('slug')
    App.shop = App.cable.subscriptions.create {channel: "ShopChannel", id: slug},
      connected: ->
        console.log('connected')

      disconnected: ->
        console.log('disconnected')

      received: (data) ->
        ele = $("[data-key='#{data.key}'] > [data-quantity-value]")

        ele.text(data.value)

        ele.addClass(data.direction).delay(1100).queue (next) ->
          $(this).removeClass(data.direction);
          next();
