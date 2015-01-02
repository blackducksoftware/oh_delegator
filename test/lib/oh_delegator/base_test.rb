require 'test_helper'

describe OhDelegator::Base do
  before do
    class User
      class ProfileCore < OhDelegator::Base
      end
    end

    class User
      extend OhDelegator::Delegable
      oh_delegators :profile_core

      def type
        :user
      end
    end
  end

  it 'must make the delegable object available to the delegator' do
    user = User.new
    user.profile_core.user.must_equal user
  end

  it 'must delegate all instance methods to the delegable' do
    User.new.profile_core.type.must_equal :user
  end
end
