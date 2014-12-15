## Usage

The delegators can be placed in any folder.
If one chooses to place the delegators inside an `app/delegators` folder, one
needs to add the following to the application's environment file:

```ruby
config.autoload_paths += "#{ RAILS_ROOT }/app/delegators"
```

```ruby
# app/delegators/account/profile_delegator.rb
class Account::ProfileDelegator < OhDelegator::Base
  has_many :profiles

  validates :has_profile, inclusion: { in: [true, false] }

  def active
    profiles.find_by(active: true)
  end
end

# app/models/account.rb
class Account < ActiveRecord::Base
  create_delegators :profile
end
```

This setup provides a `profile_delegator` method on `account`. The usage will be:

```ruby
@account.profile_delegator.active
```
