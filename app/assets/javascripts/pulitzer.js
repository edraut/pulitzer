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

if (typeof wysihtml5Stylesheets === 'undefined') {
  var wysihtml5Stylesheets = []
}

var Select2Trigger = Class.extend({
  init: function(jq_obj){
    jq_obj.select2({ tags: true });
  }
});

var RichTextEditor = Class.extend({
  init: function($textarea){
    var rich_text_editor = this
    this.$form = $textarea.parents("form")
    this.$toolbar = this.$form.find('[data-pulitzer-toolbar]')
    this.editor = new wysihtml5.Editor($textarea[0], {
      toolbar: rich_text_editor.$toolbar[0],
      stylesheets: wysihtml5Stylesheets,
      parserRules: wysihtml5ParserRules
    });
  }
})

var ContextEditor = Class.extend({
  init: function($content_element){
    if(typeof(window.thin_man) != 'undefined'){
      this.$content_element = $content_element
      this.editor_url = $content_element.data('context-editor')
      $editor_link = $('<a>')
        .attr('href',this.editor_url)
        .text('✎')
        .attr('data-ajax-link',true)
        .attr('data-ajax-target','[data-context-editor="' + this.editor_url + '"]')
      $content_element.append($editor_link)
    }
  },
  reveal_edit_link: function(){
    var edit_link =
    this.$content_element.append(edit_link)
  }
})

$(document).ajaxComplete(function(){
  if(window.any_time_manager.recordedObjects["RichTextEditor"]){
    $.each(window.any_time_manager.recordedObjects["RichTextEditor"], function(){
      if(this.$form.parents('body').length == 0){ //the form has been removed from the dom
        this.editor.fire('destroy:composer')
      }
    })
  }
})

$(document).ready(function(){
  window.any_time_manager.registerList([ 'select2-trigger', 'rich-text-editor', 'context-editor' ]);
  window.any_time_manager.load();
});
