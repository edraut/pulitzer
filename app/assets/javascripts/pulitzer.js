var UploadifyTrigger = Class.extend({
  init: function(jq_obj){
    var uploader_class = this;
    var $form = jq_obj.parents('form');
    jq_obj.uploadify({
      swf: $form.data('swfPath'),
      uploader: $form.data('serverEndpoint'),
      fileObjName: 'content_element[image]',
      'onUploadStart': function(file) {
        jq_obj.uploadify('settings', 'formData', uploader_class.settings(this));
      },
      'onUploadComplete': function(file){
        location.reload();
      }
    });
  },
  settings: function(input){
    var $form = $("#" + input.movieName).parents('form');
    var form_data_array = $form.serializeArray();
    var form_data = this.arrayToObject(form_data_array);
    return form_data
  },
  arrayToObject: function(array){
    params_object = [];
    $.each(array, function(index, item){
      if(item.name != "file_upload"){
        params_object[item.name] = item.value;
      }
    })
    return params_object;
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

  window.any_time_manager.registerList( [ 'uploadify-trigger' ] );
  window.any_time_manager.load();
});
