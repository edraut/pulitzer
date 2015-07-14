// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_tree .
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
