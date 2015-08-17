$(document).ready(function(){

  var post_type_content = function(){
    $dimensionsFields = $(this).parent().find($('.image_dimensions')).first();

    if ($('option:selected', this).text() == "Image"){
      $dimensionsFields.show();
    } else {
      $dimensionsFields.hide();
    }
  }

  function arrayToObject(array){
    params_object = [];
    $.each(array,function(index,item){
      if(item.name!="file_upload"){
        params_object[item.name] = item.value;
      }
    })
    return params_object;
  };

  function uploadifySettings(input){
    var $input = $(input);
    var $form = $input.parents('form');
    var form_data_array = $form.serializeArray();
    var form_data = arrayToObject(form_data_array);
    return form_data
  }

  $('.uploadify-image').each(function(){
    var $this = $(this);
    var $form = $this.parents('form');
    $(this).uploadify({
      swf: $form.data('swfPath'),
      uploader: $form.data('serverEndpoint'),
      fileObjName: 'content_element[image]',
      'onUploadStart': function(file) {
        $this.uploadify('settings', 'formData', uploadifySettings($this));
      }
    });
  })

});
