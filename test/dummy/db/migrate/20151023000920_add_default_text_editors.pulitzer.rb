# This migration comes from pulitzer (originally 20151022221236)
class AddDefaultTextEditors < ActiveRecord::Migration
  def up
    ["None", "Simple text editor"].each do |name|
      Pulitzer::TextEditor.create(name: name)
    end
  end

  def down
    Pulitzer::TextEditor.destroy_all
  end
end
