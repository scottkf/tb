require 'spec_helper'

describe Author do
  include ArticleSpecHelper
   
  context "#valid" do
    describe "presence" do
      it "should only be valid with all attributes" do
        @author = Author.create()
        @author.should be_invalid
        
        @author.attributes = valid_author_attributes
        @author.save()
        @author.should be_valid
      end
    end
    
    describe "email" do
      it "should be a valid email" do
        @author = Author.new(valid_author_attributes)
        @author.email ="fk....fk.com"
        @author.save
        @author.should be_invalid
        
      end
      
      it "should be a unique email" do
        @author = Author.create(valid_author_attributes)
        @author_two = Author.create(valid_author_attributes)
        @author_two.should be_invalid
      end
    end
    
    
  end
  
  context "#admin" do
    
  end
end
