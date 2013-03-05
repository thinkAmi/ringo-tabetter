class ChangeColumnToApples < ActiveRecord::Migration
  def self.up
    change_column :apples, :tweet_id, :integer, :limit => 8
  end

  def self.down
    change_column :apples, :tweet_id, :integer
  end
end
