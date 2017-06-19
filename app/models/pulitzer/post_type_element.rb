module Pulitzer
  module PostTypeElement
    def self.included(klass)
      klass.before_save :handle_sort_order
    end

    def highest_sibling_sort
      self.post_type_version.highest_element_sort
    end

    def handle_sort_order
      self.sort_order ||= self.highest_sibling_sort + 1
    end

  end
end