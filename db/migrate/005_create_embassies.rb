class CreateEmbassies < ActiveRecord::Migration
  def self.up
    create_table :embassies do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :embassies
  end
end
