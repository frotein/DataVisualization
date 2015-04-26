# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
row_count = 5
$ ->
	$("#add_row").click -> 
		dom_string  = "<div class='json_row'><input id='var#{row_count}' type='text' name='var#{row_count}'></input> = "
		dom_string = dom_string + "<input id='val#{row_count}' type='text' name='val#{row_count}'></input></div>"
		$("#json_rows").append(dom_string)

		row_count = row_count + 1
