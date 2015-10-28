var Select2Trigger = Class.extend({
  init: function(jq_obj){
    jq_obj.select2({ tags: true });
  }
});

var RichTextEditor = Class.extend({
  init: function($textarea){
    self.$form = $textarea.parents("form");
    self.$toolbar = self.$form.find('[data-pulitzer-toolbar]');
    self.editor = new wysihtml5.Editor($textarea[0], {
      toolbar: self.$toolbar[0],
      parserRules:  wysihtml5ParserRules
    });
  }
})

$(document).ready(function(){
  window.any_time_manager.registerList([ 'select2-trigger', 'rich-text-editor' ]);
  window.any_time_manager.load();
});
