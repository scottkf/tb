require 'spec_helper'

describe User do

   
  context "#valid" do
    describe "presence" do
      it "should only be valid with all attributes" do
        @user = User.create()
        @user.should be_invalid
        
        @user = User.make
        @user.save
        @user.should be_valid
      end
    end
    
    describe "roles" do
      it "should have a default role, even if none is given" do
        @user = User.make!
        @user.roles.each do |r|
          r.name.should == "Regular" 
        end
      end
    end
    
    describe "email" do
      it "should be a valid email" do
        @user = User.make(:email => nil)
        @user.email ="fk....fk.com"
        @user.save
        @user.should be_invalid
        
      end
      
      it "should be a unique email" do
        @user = User.make!(:email => "hello@hello.com")
        @user_two = User.make(:email => "hello@hello.com")
        @user_two.should be_invalid
      end
    end
    
    
  end
  
  context "#admin" do
    
  end
end
