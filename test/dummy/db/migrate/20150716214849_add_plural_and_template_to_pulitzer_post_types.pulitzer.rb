# This migration comes from pulitzer (originally 20150629195832)
class AddPluralAndTemplateToPulitzerPostTypes < ActiveRecord::Migration
  def change
    add_column :pulitzer_post_types, :plural, :boolean
    add_column :pulitzer_post_types, :template, :boolean
  end
end
