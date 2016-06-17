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
      this.getContentElementType()
      this.editor_url = $content_element.data('context-editor')
      $editor_link = $('<a>')
        .attr('href',this.editor_url)
        .text('✎')
        .attr('data-ajax-link',true)
        .attr('data-ajax-target','#' + $content_element.attr('id'))
      this.content_element.display($editor_link)
    }
  },
  reveal_edit_link: function(){
    var edit_link =
    this.$content_element.append(edit_link)
  },
  getContentElementType: function(){
    switch(this.$content_element.get(0).nodeName.toLowerCase()){
      case 'img':
        this.content_element = new ImageContentElement(this.$content_element)
      break;

      default:
        this.content_element = new GenericContentElement(this.$content_element)
      break;
    }

  }
})

var GenericContentElement = Class.extend({
  init: function($content_element){
    this.$content_element = $content_element
  },
  display: function($editor_link){
    this.$content_element.append($editor_link)
  }
})

var ImageContentElement = Class.extend({
  init: function($content_element){
    this.$content_element = $content_element
  },
  display: function($editor_link){
    var offset = this.$content_element.offset()
    var top = offset.top
    var left = offset.left
    $editor_link.css({position: 'absolute', top: top, left: left})
    $editor_link.attr('data-insert-method','replaceWith')

    $('body').append($editor_link)
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
