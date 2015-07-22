$(document).ready(function(){
  $(document).on('change', '#post_type_content_element_type_content_element_type_id', function(){
    $dimensionsFields = $(this).parent().find($('.image_dimensions')).first();
    if ($('option:selected', this).text() == "Image"){
      $dimensionsFields.show();
    } else {
      $dimensionsFields.hide();
    }
  });
});
