class Pulitzer::UpdateContentElement

  def initialize(content_element, params)
    @content_element, @params = content_element, params.dup
  end

  def call
    text_editor = Pulitzer.text_editor_toolbars.detect { |toolbar| toolbar[:name] == content_element.text_editor }
    if 'Kramdown' == text_editor[:kind]
      params[:body] = Kramdown::Document.new(params[:body]).to_html
    end
    @content_element.update params
  end

end
