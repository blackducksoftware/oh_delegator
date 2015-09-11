require 'delegate'

module OhDelegator
  class Base < SimpleDelegator
    extend ParentScope

    class << self
      def inherited(subclass)
        delegatee_name = subclass.parent.name.downcase
        define_method(delegatee_name, -> { __getobj__ })
      end
    end
  end
end
