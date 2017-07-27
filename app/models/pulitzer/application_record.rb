class Pulitzer::ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.assoc_name
    @assoc_name ||= name.demodulize.underscore.pluralize
  end

  def self.attrs_name
    @attrs_name ||= assoc_name + '_attributes'
  end

  def self.convert_hash_to_nested(json_hash)
    if json_hash.has_key? assoc_name
      json_hash[attrs_name] = json_hash[assoc_name]
      json_hash.delete assoc_name
    end
    convert_nested_assoc json_hash
  end

  def self.convert_nested_assoc(json_hash)
    json_hash
  end

end
