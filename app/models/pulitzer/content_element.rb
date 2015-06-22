module Pulitzer
  class ContentElement < ActiveRecord::Base
    belongs_to :post
  end
end
