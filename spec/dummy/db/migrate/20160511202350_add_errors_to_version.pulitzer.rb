# This migration comes from pulitzer (originally 20160122204201)
class AddErrorsToVersion < ActiveRecord::Migration
  def change
    add_column :pulitzer_versions, :cloning_errors, :jsonb
  end
end
