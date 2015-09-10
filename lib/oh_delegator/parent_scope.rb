module OhDelegator
  module ParentScope
    def parent_scope(&block)
      parent.class_exec(&block)
    end
  end
end
