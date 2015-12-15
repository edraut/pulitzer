def setup_db
  text = Pulitzer::ContentElementType.create(name: 'Text')
  post_type = Pulitzer::PostType.create(name: 'Winterfell News', plural: false, kind: Pulitzer::PostType.kinds[:template])
  3.times do |i|
    post_type.post_type_content_element_types.create(label: "Slide 1 content element #{i}", content_element_type: text)
  end

end
setup_db