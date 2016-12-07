class ChangeLabelTypeFromPulitzerPostTags < ActiveRecord::Migration
  def change
    change_column :pulitzer_post_tags, :label_type, :string
  end
end
