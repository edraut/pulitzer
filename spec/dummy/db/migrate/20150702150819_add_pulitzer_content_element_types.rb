class AddPulitzerContentElementTypes < ActiveRecord::Migration
  ELEMENT_TYPES = %w(Text Image Video)

  def up
    ELEMENT_TYPES.each do |type|
      Pulitzer::ContentElementType.create(name: type)
    end
  end

  def down
    Pulitzer::ContentElementType.where(name: ELEMENT_TYPES).destroy_all
  end
end
