## Inspiration

From [Wikipedia](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself):

> The DRY principle is stated as “Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.”

## Delegators vs Concerns

ActiveSupport::Concern is a convenient solution for splitting ActiveRecord models. It can serve as a single and authoritative feature representation, but it is ambigous. Consider the following example:

```ruby
# app/models/concerns/account_profile.rb
module AccountProfile
  extend ActiveSupport::Concern

  included do
    has_many :profiles

    validates :has_profile, inclusion: { in: [true, false] }
  end

  def active_profile
    profiles.find_by(active: true)
  end
end

# app/models/account.rb
class Account < ActiveRecord::Base
  include AccountProfile
end

# app/controllers/accounts_controller.rb
...
  def index
    @profile = @account.active_profile
  end
...
```

When viewing the controller, the location of `@account.active_profile` seems ambigous. The first thing that most developers would do is look at the `Account` model. Tools like ctags can help, but they have other limitations(e.g. cannot deal with duplicate method names in separate modules).

Delegators are more ideal as they comply with all three requirements of DRY. Also, it makes way for editor plugins to accurately track source location. However it lacks any convenient wrapper like `ActiveSupport::Concern` for working with ActiveRecord. This gem serves to fill that gap.

## Usage

The delegators can be placed anywhere in your application's load path, the only requirement is that it must be nested under the delegable object.

```ruby
# app/delegators/account/profile_delegator.rb
class Account::ProfileDelegator < OhDelegator::Base
  parent_scope do
    has_many :profiles

    validates :has_profile, inclusion: { in: [true, false] }
  end

  def active
    profiles.find_by(active: true)
  end
end

# app/models/account.rb
class Account < ActiveRecord::Base
  oh_delegators :profile_delegator
end

# app/controllers/accounts_controller.rb
...
  def index
    @profile = @account.profile_delegator.active
  end
...
```

As we see, migrating code from an **ActiveRecord** model to a delegator is as simple as migrating a concern.
