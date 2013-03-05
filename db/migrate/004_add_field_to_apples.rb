class AddFieldToApples < ActiveRecord::Migration
  def self.up
    change_table :apples do |t|
      t.datetime :tweeted_at
    end
  end

  def self.down
    change_table :apples do |t|
      t.remove :tweeted_at
    end
  end
end
