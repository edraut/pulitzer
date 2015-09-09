var Select2Trigger = Class.extend({
  init: function(jq_obj){
    jq_obj.select2({ tags: true });
  }
});

$(document).ready(function(){
  $(document).on('change', '#post_type_content_element_type_content_element_type_id', function(){
    $dimensionsFields = $(this).parent().find($('.image_dimensions')).first();
    if ($('option:selected', this).text() == "Image"){
      $dimensionsFields.show();
    } else {
      $dimensionsFields.hide();
    }
  });

  window.any_time_manager.registerList([ 'select2-trigger' ]);
  window.any_time_manager.load();

});
