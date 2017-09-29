// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require jquery_ujs
//= require toastr
//= require bootstrap-sprockets
//= require jquery.timepicker.js
//= require Datepair
//= require jquery.datepair.js
//= require bootstrap-datepicker
//= require summernote




$(document).on('turbolinks:load', function() {

	$('form').on('click', '.remove_record', function(event) {
		$(this).prev('input[type=hidden]').val('1');
		$(this).closest('section').hide();
		return event.preventDefault(); 
	});

	$('form').on('click', '.add_fields', function(event){
		var regexp, time; 
		time = new Date().getTime();
		regexp = new RegExp($(this).data('id'), 'g');
		$('.fields').append($(this).data('fields').replace(regexp, time));
		return event.preventDefault();
	})

	$('form').on('click', '.add_fieldsq', function(event){
		var regexp, time; 
		time = new Date().getTime();
		regexp = new RegExp($(this).data('id'), 'g');
		$('.fieldsq').append($(this).data('fieldsq').replace(regexp, time));
		return event.preventDefault();
	})

	$('form').on('click', '.add_fieldss', function(event){
		var regexp, time; 
		time = new Date().getTime();
		regexp = new RegExp($(this).data('id'), 'g');
		$('.fieldss').append($(this).data('fieldss').replace(regexp, time));
		return event.preventDefault();
	})

	$('form').on('click', '.add_fieldssponsor', function(event){
		var regexp, time; 
		time = new Date().getTime();
		regexp = new RegExp($(this).data('id'), 'g');
		$('.fieldssponsor').append($(this).data('fieldssponsor').replace(regexp, time));
		return event.preventDefault();
	})


});





