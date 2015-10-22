class Pulitzer::TextEditor < ActiveRecord::Base
  has_many :post_type_content_element_types

  def normalized_name
    name.parameterize('_')
  end
end
