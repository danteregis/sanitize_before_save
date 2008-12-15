# SanitizeModelFields
module SanitizeModelFields

  module SanitizeInstanceMethods
    def sanitize_field_values
      self.class.skip_sanitize_fields ||= []
      self.attributes.each do |attr, value|
        if value.is_a?(String) && !self.class.skip_sanitize_fields.include?(attr)
          self.send(attr + "=", sanitize(value))
        end
      end
    end
  end

  module SanitizeClassMethods
    # If we don't want a specific field to be sanitized before being saved on
    # the database, we use this function with a list of fields as an array.
    # for example:
    # class Person < ActiveRecord::Base
    #   sanitize_before_save :except => [:name, :memo] 
    # end
    def sanitize_before_save(args = {})
      cattr_accessor :skip_sanitize_fields
      if args[:except]
        args[:except] = [args[:except]] unless args[:except].is_a?(Array)
        self.skip_sanitize_fields ||= []
        args[:except].each do |a|
          self.skip_sanitize_fields << a.to_s
        end
      end
      include ActionView::Helpers::SanitizeHelper
      extend ActionView::Helpers::SanitizeHelper::ClassMethods
      include SanitizeModelFields::SanitizeInstanceMethods
      before_validation :sanitize_field_values
    end
  end

end

ActiveRecord::Base.extend SanitizeModelFields::SanitizeClassMethods
