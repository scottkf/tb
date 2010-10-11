class UsersHaveAndBelongToManyRoles < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.references :role, :user
    end
    User.update_all ["role_id = ?", 2]
  end
 
  def self.down
    drop_table :roles_users
  end
end