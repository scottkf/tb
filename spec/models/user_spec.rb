require 'spec_helper'

describe User do
  include ArticleSpecHelper
   
  context "#valid" do
    describe "presence" do
      it "should only be valid with all attributes" do
        @user = User.create()
        @user.should be_invalid
        
        @user.attributes = valid_author_attributes
        @user.save()
        @user.should be_valid
      end
    end
    
    describe "roles" do
      it "should have a default role, even if none is given" do
        @user = User.make
        @user.roles.should have(1).things
      end
    end
    
    describe "email" do
      it "should be a valid email" do
        @user = User.new(valid_author_attributes)
        @user.email ="fk....fk.com"
        @user.save
        @user.should be_invalid
        
      end
      
      it "should be a unique email" do
        @user = User.create(valid_author_attributes)
        @user_two = User.create(valid_author_attributes)
        @user_two.should be_invalid
      end
    end
    
    
  end
  
  context "#admin" do
    
  end
end
