class CreateBadgeSets < ActiveRecord::Migration
  def change
    create_table :table do |t|
      t.string :column,  null:  false
      t.timestamps
    end
  end
end
