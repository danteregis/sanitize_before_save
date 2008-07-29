require File.dirname(__FILE__) + '/../spec_helper'

describe "Sanitize Before Save" do
  before do
    @name = %(Hello<script>alert('coucou');</script>)
    @description =  %(Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    <script type="text/javascript" charset="utf-8">
    	while(true) {
    	  alert('Hello !');
    	}
    </script>
    )
  end
  
  describe "With No Options" do
    before do
      @model_to_sanitize = SanitizeModel
    end
    
    it "should sanitize Javascript tags" do
      @result = @model_to_sanitize.create({
        :name         => @name,
        :description  => @description,
        :count        => 5
      })
      @result.name.should == "Hello"
      @result.description.strip.should == "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
      @result.count.should == 5
    end
  end


  describe "With Except Options" do
    before do
      @model_to_sanitize = SanitizeWithExceptOptionModel
    end
    
    it "should sanitize Javascript tags only in name field" do
      @result = @model_to_sanitize.create({
        :name         => @name,
        :description  => @description
      })
      @result.name.should == "Hello"
      @result.description.should == @description
    end
  end
  
end
