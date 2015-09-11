module OhDelegator
  class ORM
    class << self
      def setup(base)
        base.class_eval do
          extend OhDelegator::Delegatee
        end
      end
    end
  end
end
