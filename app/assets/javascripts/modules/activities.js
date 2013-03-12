$(document).ready(function(){
  $("#new_activity").live('click focus', function(){
    $('#new_activity').validate({
      rules: {
        "activity_name": {
          required: true,
          minlength: 3
        },
        activity_description:{
          required: true
        },
        activity_coworking_space_id:{
          required: true,
        },
        tickets_total:{
          required: "#tickets_total:filled",
          number: true,
          min: 1
        },
        tickets_num_separados:{
          required: "#tickets_total:filled",
          min: 1
        },
        activity_date:{
          required: true,
          dateISO: true
        }

      }
    });
  });
    
  $("#coworking_space_name").live('click focus', function(){
        
    $("#coworking_space_name").autocomplete({
      source: function(request, response) {
        $.ajax({
          url: "/coworking_spaces/search_by_name",
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
                label: item.coworking_space.name,
                value: item.coworking_space.name,
                hidden: item.coworking_space.id
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
          $('#activity_coworking_space_id').val(ui.item.hidden)
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

  $('#activities-wrapper #coworking_space_id').live('change', function(event){
    
    var cws_id = $(this).val();
    $.ajax({
      url: '/item_categories/by_coworking_space',
      type: 'POST',
      data: {
        coworking_space_id: cws_id
      },
      success: function(data){
        $('#reservation_item_category').html(data);
      }
    });
  });

  $('#activities-wrapper #options_item_category').live('change', function(event){
    var cws_id = $('#coworking_space_id').val();
    var ic_id = $(this).val();
    $.ajax({
      url: '/tables/by_item_category',
      type: 'POST',
      data: {
        coworking_space_id: cws_id,
        item_category_id: ic_id
      },
      success: function(data){
        $('#reservation_table').html(data);
      }
    });
  });

  $('#activities-wrapper .calendar, #activities-wrapper #options_num_times, #activities-wrapper #activity_duration').live('change click keypress', function(){
    var init_date = $('#activity_start_date').val();
    var init_time = $('#attempt_init_time').val();
    var duration = $('#activity_duration').val();
    var recurrent_type = $('#options_recurrent_type').val();
    var recurrent = $('#activity_recurrent').val();
    var num_times = $('#options_num_times').val();
    var table_id = $('#options_table_id').val();
    
    $.ajax({
      url: '/tables/validate_reservation_datetime',
      dataType: "json",
      data: {
        init_date: init_date,
        init_time: init_time,
        id: table_id,
        duration: duration,
        recurrent_type: recurrent_type,
        recurrent: recurrent,
        num_times: num_times
      },
      type: 'GET',
      beforeSend: function(object){
        $('#options_valid_dates').val("");
        $('#validation_result').hide();
        $('#reservation_submit').attr('disabled', false);
        if(init_date && init_time && table_id && duration){
          return true;
        }
        
        return false;
      },
      success: function(data){
        $('#valid-dates').empty();
        $('#invalid-dates').empty();

        var valid_date_list = $('#options_valid_dates').val();
        $.each(data.valid_dates, function(index, value){
          $('#valid-dates').append(value+"<br />");
          valid_date_list += (value+", ")
          $('#options_valid_dates').val(valid_date_list);
        })

        if(!$('#validation_result').is(':visible')){
          $('#validation_result').show();
          $('#message').empty();
          $('#message').html(data.message);
          $('#next_available_time').html("");

        }
        if(data.valid == false){
          $('#reservation_submit').attr('disabled', true);
          $('#next_available_time').html("Puedes reservar este item a partir de las: "+data.next_available_time);
          $.each(data.invalid_dates, function(index, value){
            $('#invalid-dates').append(value+"<br />");
          })
        }


      }
    });
  });

  
  
});
