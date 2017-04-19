// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load',function(){
    $('#file-avatar').on('change',function(evt){
        var reader = new FileReader();
        reader.readAsDataURL(evt.target.files[0]);
        reader.onloadend = function(evt){
            $('#img-avatar').attr('src', evt.target.result);
        }
    });
});
