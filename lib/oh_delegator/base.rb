module OhDelegator
  class Base < SimpleDelegator
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
