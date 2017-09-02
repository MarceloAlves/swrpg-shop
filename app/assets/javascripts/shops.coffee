# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->  
  $('.table').stupidtable().bind 'aftertablesort', (event, data) ->
    icon = if data.direction == 'asc' then "fa-caret-down" else "fa-caret-up"
    $(this).find("i.fa").remove()
    $(this).find("i.fa").remove()
    data.$th.append("<i class='ml-2 fa " + icon + "'></i>")
