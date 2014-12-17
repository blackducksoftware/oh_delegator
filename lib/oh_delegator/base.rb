module OhDelegator
  class Base
    def initialize(delegable)
      instance_variable_set("@#{ delegable_name }", delegable)
    end

    private

    def delegable_name
      @delegable_name ||= self.class.delegable_name
    end

    def delegable_object
      instance_variable_get("@#{ delegable_name }")
    end

    def method_missing(method_name, *args)
      delegable_object.send(method_name, *args)
    rescue NoMethodError
      super
    end

    class << self
      def parent_scope(&block)
        delegable.class_exec(&block)
      end

      def delegable_name
        @delegable_name ||= name.slice(/^[^:]+/)
      end

      private

      def delegable
        @delegable ||= delegable_name.constantize
      end
    end
  end
end
