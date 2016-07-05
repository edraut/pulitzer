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
    this.$textarea = $textarea
    var editor_kind = $textarea.data('rich-text-editor')
    var editor_class_name = editor_kind + 'Editor'
    var editor_class = eval(editor_class_name)
    this.editor = new editor_class($textarea)
  },
  handleRemove: function(){
    this.editor.handleRemove()
  }
})

var TinyMCEEditor = Class.extend({
  init: function($textarea){
    this.editor_selector = $textarea.data('editor-selector')
    this.editor_id = $textarea.attr('id')
    this.custom_params = $textarea.data('mce-params')
    var tinymceeditor = this;
    var editor_params = this.getParams()
    tinymce.init(this.getParams())
  },
  handleRemove: function(){
    if($(this.editor_selector).length == 0){
      var editor = this
      $.each(tinymce.editors, function(){if(this.id == editor.editor_id){this.destroy()}})
    }
  },
  getParams: function(){
    if(this.custom_params){
      var these_params = $.extend({},this.defaultParams(),this.custom_params)
    } else {
      var these_params = this.defaultParams()
    }
    return these_params
  },
  defaultParams: function(){
    return {
      selector: this.editor_selector,
      plugins: "link",
      menubar: false,
      insert_toolbar: 'link unlink',
      toolbar: 'undo redo | styleselect | bold italic | link',
      statusbar: false
    }
  }
})

var WysiHtmlEditor = Class.extend({
  init: function($textarea){
    var rich_text_editor = this
    this.$form = $textarea.parents("form")
    this.$toolbar = this.$form.find('[data-pulitzer-toolbar]')
    this.editor = new wysihtml5.Editor($textarea[0], {
      toolbar: rich_text_editor.$toolbar[0],
      stylesheets: wysihtml5Stylesheets,
      parserRules: wysihtml5ParserRules
    });
  },
  handleRemove: function(){
    if(this.$textarea.parents('body').length == 0){ //the form has been removed from the dom
      this.editor.fire('destroy:composer')
    }    
  }
})

var ContentElementEditor = Class.extend({
  init: function($content_element){
    if(typeof(window.thin_man) != 'undefined'){
      this.$content_element = $content_element
      var content_element_editor = this
      $content_element.on('hover', function(){
        content_element_editor.reveal_edit_link()
      })
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
      this.handleRemove();
    })
  }
})

$(document).ready(function(){
  // window.any_time_manager.registerListWithClasses(
  //   { 'pulitzer-element' : 'ContentElementEditor'}
  // )
  window.any_time_manager.registerList([ 'select2-trigger', 'rich-text-editor' ]);
  window.any_time_manager.load();
});
