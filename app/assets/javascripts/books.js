// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load',function(){
    $('#frm-new-book').on('click', '.btn-add-question', function(evt){
        evt.preventDefault();
        var regex = new RegExp($(this).attr('data-id'), 'g');   
        $(".questions").append("<div class='question'>" + $(this).data('fields').replace(regex, new Date().getTime()) + "</div>");
    }); 
    $('#frm-new-book').on('click', '.btn-remove-question', function(evt){
        evt.preventDefault();
        $(this).prev("input[type=hidden]").val("1");
        $(this).closest(".question").hide();
    }); 
});