// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load',function(){
    $('.comments').on('click', '.btn-reply-comment', function(evt){
        evt.preventDefault();
        var formID = $(this).data('form');
        $("#" + formID).removeClass('hidden');
    });
});