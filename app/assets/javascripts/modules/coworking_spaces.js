$(document).ready(function(){

  $("#new_coworking_space").live('click focus', function(){
    $('#new_coworking_space').validate({
      rules: {
        "coworking_space_name": {
          required: true,
          minlength: 3
        },
        coworking_space_city_id:{
          required: true
        },
        coworking_space_user_id:{
          required: true
        },
        coworking_space_category_id:{
          required: true
        }

      }
    });
  });

  $("#cws_user_name").live('click focus', function(){
    $("#cws_user_name").autocomplete({
      source: function(request, response) {
        $.ajax({
          url: "/users/search_by_name",
          dataType: "json",
          data: {
            featureClass: "P",
            style: "full",
            maxRows: 12,
            term: request.term,
            format: 'json'
          },
          success: function(data) {
                        
            response($.map(data, function(item) {
              //console.log(item)
              return {
                label: item.user.name,
                value: item.user.name,
                hidden: item.user.id
              }
            }));
          }
        })
      },
      minLength: 2,
      select: function(event, ui) {
        //console.log(ui)
        //console.log(ui.item ? ("Selected: " + ui.item.label) : "Nothing selected, input was " + this.value);
        if (ui.item) {
          $('#coworking_space_user_id').val(ui.item.hidden)
        }

      },
      open: function() {
        $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
      },
      close: function() {
        $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
      }
    });
  });

  $('.choose-line-item').live('click, change', function(){
    var rowParent = $(this).parent().parent();
    var inputs = rowParent.find("input[type!=checkbox][type!=hidden]");
    if($(this).is(":checked")) {
      $.each(inputs, function(index, value){
        $(value).attr("disabled", false);
      });
    } else {      
      $.each(inputs, function(index, value){
        $(value).attr("disabled", true);
      });
    }
      
  });

  
});