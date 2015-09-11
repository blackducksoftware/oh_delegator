require 'test_helper'

describe OhDelegator::Delegatee do
  it 'must add an oh_delegators method when extended' do
    class Person
      extend OhDelegator::Delegatee
    end

    Person.methods.must_include :oh_delegators
  end

  describe 'oh_delegators' do
    before do
      class User
        class ProfileCore < OhDelegator::Base
        end
      end

      class User
        extend OhDelegator::Delegatee
        oh_delegators :profile_core
      end
    end

    it 'must add a accessor for given delegators' do
      User.new.profile_core.must_be :present?
    end

    it 'must make the accessor return a delegator object' do
      User.new.profile_core.class.ancestors.first.must_equal User::ProfileCore
    end
  end
end
