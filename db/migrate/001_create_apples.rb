class CreateApples < ActiveRecord::Migration
  def self.up
    create_table :apples do |t|
      t.string :name
      t.integer :tweet_id
      t.datetime :created_at
      t.string :tweet
      t.timestamps
    end
  end

  def self.down
    drop_table :apples
  end
end
