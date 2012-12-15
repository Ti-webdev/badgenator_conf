class CreateBadgeSets < ActiveRecord::Migration
  def change
    create_table :badge_sets do |t|
      t.string :name,  null:  false
      t.string :image
      t.timestamps
    end
  end
end
