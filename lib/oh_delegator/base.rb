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
      def inherited(base)
        # Find an alternative like deconstantize
        delegable_name = base.to_s.slice(/^[^:]+/)
        base.set_delegable(delegable_name)
      end

      def delegable_name
        delegable_object.to_s.underscore
      end

      protected

      def set_delegable(delegable_name)
        @delegable_object = delegable_name.constantize
      end

      private

      def delegable_object
        @delegable_object
      end

      def method_missing(method_name, *args)
        delegable_object.send(method_name, *args)
      rescue NoMethodError
        super
      end
    end
  end
end
