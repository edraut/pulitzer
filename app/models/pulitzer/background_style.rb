module Pulitzer
  class BackgroundStyle < ActiveRecord::Base
    belongs_to :post_type_version
    has_many :partials
    validates :display_name, presence: true
    validates :css_class_name, presence: true

    def clone_me
      clone_attrs = self.attributes.dup
      clone_attrs.delete 'id'
      clone_attrs.delete 'post_type_version_id'
      Pulitzer::BackgroundStyle.new(clone_attrs)
    end
  end
end
