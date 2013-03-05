class RenameSearchedMaxIdToTweets < ActiveRecord::Migration
  def self.up
    rename_column :tweets, :searched_max_id, :last_searched_id
  end

  def self.down
    rename_column :tweets, :last_searched_id, :searched_max_id
  end
end
