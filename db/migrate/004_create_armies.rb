class CreateArmies < ActiveRecord::Migration
  def self.up
    create_table :armies do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :armies
  end
end
