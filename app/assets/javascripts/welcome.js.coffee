# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  # Button click js handler
  $('button.btn[data-click]').click (event) ->
    event.preventDefault()
    window.location = $(this).data 'click'

  # Auto dismiss for notice
  $('.alert[data-autoclose]').alert()
  setTimeout (-> $('.alert[data-autoclose]').alert('close')), 2000
  
  # Disabled buttons and links
  $('.disabled').click (event) ->
    event.preventDefault()
  
  # Print switcher
  $('.print-switcher .btn').click (event) ->
    event.preventDefault()
    return false if $(this).hasClass('active')
    
    $('.page-brake').remove();
    
    page_brake = $('<div class="page-brake">&nbsp;</div>')
    separeted  = if $(this).hasClass('btn-primary') then '4n + 4' else '3n + 3'
    
    $(".badges .badge-kh:nth-child(#{ separeted })").each ->
      $(page_brake).clone().insertAfter $(this)
    
    