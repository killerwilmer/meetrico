$ ->
  $('#banner_slider').carousel({interval: 5000})
  $('.modal-promo-show').on 'click', ->
    $('#contact_message_item_category_id').val($(@).data('item-category-id'))
    redirection_url = $(@).data('url')
    $('#modal_newsletter_email_box').data 'url', redirection_url
    $('#contact_message_url').val(redirection_url)

  $('#modal_newsletter_email_box').on 'hidden', ->
    window.location.replace $(@).data('url')
