class AddCommentsDisabledToArticle < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.boolean :comments_disabled, :default => false
    end
    Article.update_all ["comments_disabled = ?", false]
  end

  def self.down
    remove_column :articles, :comments_disabled
  end
end
