require 'test_helper'

describe OhDelegator::ParentScope do
  before do
    class User
      class << self
        attr_reader :class_name

        def set_class_name
          @class_name = name
        end
      end

      class ProfileCore < OhDelegator::Base
        parent_scope do
          set_class_name
        end
      end
    end

    class User
      extend OhDelegator::Delegable
      oh_delegators :profile_core
    end
  end

  describe 'any method defined in parent_scope' do
    it 'must be called at compile time' do
      User.class_name.must_be :present?
    end

    it 'must be called using delegable\'s context' do
      User.class_name.must_equal 'User'
    end
  end
end

