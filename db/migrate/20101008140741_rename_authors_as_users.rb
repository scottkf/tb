class RenameAuthorsAsUsers < ActiveRecord::Migration
  def self.up
    rename_table :authors, :users
    rename_column :articles, :author_id, :user_id
  end
  
  def self.down
    rename_table :users, :authors
    rename_column :articles, :user_id, :author_id
  end
end