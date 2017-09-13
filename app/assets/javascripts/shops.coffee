# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateSelectedText =  ->
  count = $('[data-sourcebook-checkbox]:checked').size()
  allCount = $('[data-sourcebook-checkbox]').size()
  $('[data-sourcebooks-selected]').html('(' + count + ' of ' + allCount + ' selected)')

$(document).on 'turbolinks:load', ->  
  updateSelectedText()
  
  $('.nav-link').each (index) ->
    target = $(this)
    target.tab('show') if $(target.attr('href')).find('tr').length > 0
    false if $('.active').length > 0

  $('.table').stupidtable().bind 'aftertablesort', (event, data) ->
    icon = if data.direction == 'asc' then "fa-caret-down" else "fa-caret-up"
    $(this).find("i.fa").remove()
    $(this).find("i.fa").remove()
    data.$th.append("<i class='ml-2 fa " + icon + "'></i>")

  $('[data-sourcebook-checkbox]').change ->
    updateSelectedText()
  
  $('#sourcebooks').on 'show.bs.collapse', ->
    collapseIcon = $('[data-collapse-icon]')
    collapseIcon.removeClass('fa-angle-left')
    collapseIcon.addClass('fa-angle-down')

  $('#sourcebooks').on 'hide.bs.collapse', ->
    collapseIcon = $('[data-collapse-icon]')
    collapseIcon.removeClass('fa-angle-down')
    collapseIcon.addClass('fa-angle-left')

  $('[data-select-all]').on 'click', (e) ->
    e.preventDefault()
    $('[data-sourcebook-checkbox]').prop('checked', 'checked')
    updateSelectedText()
  
  $('[data-select-none]').on 'click', (e) ->
    e.preventDefault()
    $('[data-sourcebook-checkbox]').removeAttr('checked')
    updateSelectedText()
