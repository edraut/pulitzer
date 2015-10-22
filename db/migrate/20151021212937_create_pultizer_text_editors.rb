class CreatePultizerTextEditors < ActiveRecord::Migration
  def up
    create_table :pultizer_text_editors do |t|
      t.string :name

      t.timestamps null: false
    end
    ["None", "Simple text editor"].each do |name|
      Pulitzer::TextEditor.create(name: name)
    end
  end

  def down
    drop_table :pultizer_text_editors
  end
end
