class FixPostTypeKinds < ActiveRecord::Migration
  def change
    Pulitzer::PostType.where(kind: [1,2]).each do |pt|
      pt.update_columns(kind: 0)
    end
  end
end
