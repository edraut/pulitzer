class AddPluralAndTemplateToPulitzerPostTypes < ActiveRecord::Migration
  def change
    add_column :pulitzer_post_types, :plural, :boolean
    add_column :pulitzer_post_types, :template, :boolean
  end
end
