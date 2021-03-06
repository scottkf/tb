class CreateCategoriesAndMore < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.string :layout
      t.string :description
      t.string :url
      t.string :ancestry
      t.timestamps
    end
    
    add_index :categories, :ancestry
    add_column :articles, :category_id, :integer, :null => false, :default => 1
    change_column :articles, :category_id, :integer, :null => false 
    
    # #create default category
    # c = Category.create(:name => "Default", :layout => "application", :description => "default category", :url => "default")
    # Article.all.each {|a| a.category_id = c.id; a.save }
    # 
    # # rename normal role
    # r = Role.find(2)
    # r.name = "Editor"
    # r.save
    # # add new, regular person role
    # r = Role.new(:name => "Regular")
    # r.id = 3
    # r.save
  end

  def self.down
    remove_index :categories, :ancestry
    drop_table :categories

    remove_column :articles, :category_id
    # r = Role.find(2)
    # r.name = "Normal"
    # r.save
    # Role.find(3).destroy
  end
end
