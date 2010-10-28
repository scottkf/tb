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
    
    describe "name" do
      it "should only have a valid first name" do
        @user = User.make(:first_name => "Mc.Error$")
        @user.should be_invalid
        @user.should have(1).error_on(:first_name)
        @user.first_name = "Mcerror"
        @user.email = "fake@fake.com"
        @user.should be_valid
      end
      it "should only have a valid last name" do
        @user = User.make(:last_name => "Newm@n3a!")
        @user.should be_invalid
        @user.should have(1).error_on(:last_name)
        @user.last_name = "Mcerror"
        @user.email = "fake@fake.com"
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
