require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

load(File.dirname(__FILE__) + '/schema.rb')

class SanitizeModel < ActiveRecord::Base
  sanitize_before_save
end

class SanitizeWithExceptOptionModel < ActiveRecord::Base
  sanitize_before_save :except => :description
end