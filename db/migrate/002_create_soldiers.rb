class CreateSoldiers < ActiveRecord::Migration
  def self.up
    create_table :soldiers do |t|
      # Army and Squad this Soldier belongs to.
      t.integer :army_id
      t.integer :squad_id

      # Soldier stats.
      t.string :name
      t.integer :health
      t.integer :armor
      t.integer :actions
      t.integer :accuracy
      t.integer :strength

      t.timestamps
    end
  end

  def self.down
    drop_table :soldiers
  end
end
