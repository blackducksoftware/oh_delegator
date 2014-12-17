module OhDelegator
  class Base < SimpleDelegator
    extend ParentScope
  end
end
