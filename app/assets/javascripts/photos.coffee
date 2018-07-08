# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', -> 
  # enable chosen js
  $('#photo_tag_ids').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '90%'
    max_selected_options: 3