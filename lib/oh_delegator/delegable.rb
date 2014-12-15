class OhDelegator
  module Delegable
    def assign_delegators(*fields)
      fields.each do |field|
        define_method "#{ field }_delegator" do
          instance_variable_name = "@#{ field }_delegator"
          instance_variable = instance_variable_get(instance_variable_name)

          return instance_variable if instance_variable

          klass = "#{ self.class.name }::#{ field.to_s.classify }Delegator".constantize
          instance_variable_set(instance_variable_name, klass.new(self))
        end
      end
    end
  end
end
