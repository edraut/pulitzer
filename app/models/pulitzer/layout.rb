module Pulitzer
  class Layout < ActiveRecord::Base
    has_many :partials
    belongs_to :post_type_version
    validates :name, presence: true

    def template_path
      name.downcase.gsub(/ /,'_').gsub(/\W/,'')
    end
  end
end
