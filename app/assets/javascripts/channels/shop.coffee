$(document).on 'turbolinks:load', ->
  if $('.shops.show').length == 1
    slug = $('[data-slug]').data('slug')
    App.shop = App.cable.subscriptions.create {channel: "ShopChannel", id: slug},
      connected: ->
        console.log('connected')

      disconnected: ->
        console.log('disconnected')

      received: (data) ->
        ele = $("[data-id='#{data.id}'] > [data-quantity-value]")
        ele.text(data.value)
