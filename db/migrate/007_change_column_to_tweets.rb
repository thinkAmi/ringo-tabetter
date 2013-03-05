class ChangeColumnToTweets < ActiveRecord::Migration
  def self.up
    change_column :tweets, :last_searched_id, :integer, :limit => 8
  end

  def self.down
    change_column :tweets, :last_searched_id, :integer
  end
end
