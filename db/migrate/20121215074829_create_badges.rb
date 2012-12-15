class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name,  null:  false
      t.string :surname
      t.string :company
      t.string :profession
      t.references :badge_set
      t.timestamps
    end
    change_table :badges do |t|
      t.index :badge_set_id
    end
  end
end
