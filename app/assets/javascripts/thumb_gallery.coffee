#= require_tree ./gallery_view
$ ->
  gallery_width = getContainerWidth()
  gallery_height = gallery_width*0.625
  $('.gallery-view').galleryView
    panel_width: gallery_width
    panel_height: gallery_height
    panel_scale: 'fit'
    autoplay: true
    show_infobar: false

getContainerWidth = ->
  gw = $('#gallery-wrapper').width()
  gw - gw*0.05