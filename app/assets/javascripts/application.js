//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require_self

$(document).ready(function(){
    $('#do_subscription_request').live('click', function(){
        $('#subscription_request_form_div').toggle();
    });

    $('.calendar').live('focus click', function(){
        $(this).datepicker({
            showOn: 'both',
            buttonImage: '/images/calendar.gif',
            buttonImageOnly: true,
            dateFormat: 'yy-mm-dd',
            constrainInput: true,
            minDate: new Date(),
            firstDay: 1
        });

    });

    $('#new_reader').live('click focus', function(){
        $('#new_reader').validate({
            rules: {
                "email_newsletter": {
                    required: "Este campo no puede ser vacio",
                    email: "Debe incluir un correo electronico valido. Ej pedro@mail.com"
                }
            }
        });
    });

    $(".wrapper_view_category_link > button").live('click focus', function(){
        var url = $(this).attr('data-url');

        $.ajax({
            url: url,
            success: function(data) {
                $(".dialog-container").empty();
                $(".dialog-container").remove();

                var dContainer = $('<div class="dialog-container"></div>');
                $('body').append(dContainer);

                dContainer.html(data);
                dContainer.dialog({
                    title: "Lista de productos",
                    width: 700,
                    maxWidth: 1000,
                    modal: true
                });
            }
        });

    });

});
