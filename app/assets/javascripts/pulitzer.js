if (typeof wysihtml5ParserRules === 'undefined') {
  var wysihtml5ParserRules = {
    classes: {
      "wysiwyg-color-gold": 1
    },
    tags: {
      "b": 1,
      "strong": { "rename_tag": "b" },
      "i": 1,
      "h1": 1,
      "p": 1,
      "span": 1,
      "ul": 1,
      "li": 1
    }
  }
}

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
