class AddPermalinkToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :permalink, :string, :unique => true
    add_index :articles, :permalink
    Article.all.each { |a| a.permalink = a.to_permalink; a.save; }
  end

  def self.down
    remove_column :articles, :permalink
  end
end
