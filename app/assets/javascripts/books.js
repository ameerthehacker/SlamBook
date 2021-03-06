// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load',function(){
    $('#frm-new-book').on('click', '.btn-add-question', function(evt){
        evt.preventDefault();
        var regex = new RegExp($(this).attr('data-id'), 'g');   
        $(".questions").append("<div class='question'>" + $(this).data('fields').replace(regex, new Date().getTime()) + "</div>");
        $(".btn-add-question_option").last().trigger('click');
    }); 
    $('#frm-new-book').on('click', '.btn-remove-question', function(evt){
        evt.preventDefault();
        $(this).prev("input[type=hidden]").val("1");
        $(this).closest(".question").hide();
    }); 
    $('#frm-new-book').on('click', '.btn-add-question_option', function(evt){
        evt.preventDefault();
        var regex = new RegExp($(this).attr('data-id'), 'g');  
        var index = $(this).data('index');
        $('.options-'+ index).append("<div class='option'>" + $(this).data('fields').replace(regex, new Date().getTime()) + "</div>");

    });
    $('#frm-new-book').on('click', '.btn-remove-option', function(evt){
        evt.preventDefault();
        $(this).prev("input[type=hidden]").val("1");
        $(this).closest(".option").hide();
    });
    $("#frm-new-book").on('click', '.rad-question-type', function(){
        var index = $(this).data('index');                    
        if($(this).val() == 'textarea'){
            $("." + index).addClass("hidden");
        }
        else{
            $("." + index).removeClass("hidden"); 
        }
    });
    var clipboard = new Clipboard('.btn-copy-book-url', {
        text: function(trigger){
            return $(trigger).data('clipboard-data');
        }
    });
   
    clipboard.on('success', function(evt){
        $(evt.trigger).children('.fa-copy-icon').removeClass('fa-clipboard');
        $(evt.trigger).children('.fa-copy-icon').addClass('fa-check');        
        $(evt.trigger).children('.btn-copy-book-url-text').text('Copied!');
        setTimeout(function(){
            $(evt.trigger).children('.fa-copy-icon').removeClass('fa-check');               
            $(evt.trigger).children('.fa-copy-icon').addClass('fa-clipboard');
            $(evt.trigger).children('.btn-copy-book-url-text').text('Copy Link');            
        },2000);
    });
});