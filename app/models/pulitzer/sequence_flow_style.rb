module Pulitzer
  class SequenceFlowStyle < Pulitzer::ApplicationRecord
    belongs_to :post_type_version
    has_many :partials
    validates :display_name, presence: true
    validates :css_class_name, presence: true

    def self.export_config
      {except: :id}
    end
    
    def clone_me
      clone_attrs = self.attributes.dup
      clone_attrs.delete 'id'
      clone_attrs.delete 'post_type_version_id'
      Pulitzer::SequenceFlowStyle.new(clone_attrs)
    end
  end
end
