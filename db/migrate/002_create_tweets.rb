class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.integer :searched_max_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
