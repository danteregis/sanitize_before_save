require File.dirname(__FILE__) + '/../spec_helper'

describe "Sanitize Before Save" do
  before do
    @model_to_sanitize = ModelToSanitize
  end
  
  it "should sanitize Javascript tags" do
    @result = @model_to_sanitize.create({
      :name => %(Hello<script>alert('coucou');</script>),
      :description => %(Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      <script type="text/javascript" charset="utf-8">
      	while(true) {
      	  alert('Hello !');
      	}
      </script>
      )
    })
    @result.name.should == "Hello"
    @result.description.strip.should == "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  end
end
