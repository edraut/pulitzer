class Pulitzer::PostTypeJsonConverter

  NON_COPY_FIELDS = ['created_at','updated_at']

  def initialize(post_type)
    @post_type = post_type
  end

  def to_json
    free_form_section_types = @post_type.free_form_section_types.as_json
    free_form_section_types = sanitize(free_form_section_types)
    post_type_content_element_types = @post_type.post_type_content_element_types.as_json
    post_type_content_element_types = sanitize(post_type_content_element_types)
    posts = @post_type.posts.as_json
  end

  def from_json
  end

  def sanitize(json_hash)
    NON_COPY_FIELDS.each do |ncf|
      json_hash.delete ncf
    end
    json_hash
  end

  def extract_partials(ffs, data)
    data['partials'].each do |partial_data|
      partial = ffs.partials.create(partial_data)
      extract_content_elements(partial, partial_data)
    end
  end

  def extract_content_elements(parent, data)
    link_ce_data(data['content_elements'])
    data['content_elements'].each do |ced|
      parent.content_elements.create(ced)
    end
  end

  def link_ce_data(data)
    data.each do |ce_data|
      ce_data['post_type_content_element_type_id'] = get_ptcet_id(ce_data['post_type_content_element_type_id'])
    end
  end

  def get_ptcet_id(old_id)
    @post_type_data['post_type_content_element_types'].detect{|ptcet| ptcet['id'] == old_id}[:new_id]
  end

end

{"id"=>76,
 "name"=>"ScenicSothebysRealty",
 "plural"=>false,
 "kind"=>"template",
 "posts"=>[{"id"=>500,
  "title"=>"ScenicSothebysRealty",
  "status"=>"unpublished",
  "slug"=>"scenicsothebysrealty"}]}