var Select2Trigger = Class.extend({
  init: function(jq_obj){
    jq_obj.select2({ tags: true });
  }
});

var ToggleContentElementAttr = Class.extend({
  init: function($list){
    var self = this;
    self.$form = $list.parents("form");
    self.toggleAttr();
    $(document).on('change', $list, function(){
      self.toggleAttr();
    });
  },
  toggleAttr: function(){
    var self = this;
    var selected = self.$form.find('[data-toggle-content-element-attr] option:selected').text().toLowerCase();
    console.log(selected);
    self.$form.find("[data-content-element-attr]").hide();
    self.$form.find("[data-content-element-attr-" + selected + "]").show();
  }
});

var RichTextEditor = Class.extend({
  init: function($textarea){
    self.editor = new wysihtml5.Editor($textarea[0], {
      toolbar: 'toolbar',
      parserRules:  wysihtml5ParserRules
    });
  }
})

$(document).ready(function(){
  window.any_time_manager.registerList([ 'select2-trigger', 'rich-text-editor', 'toggle-content-element-attr' ]);
  window.any_time_manager.load();
});
