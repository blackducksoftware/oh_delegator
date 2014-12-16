require 'rails/railtie'

module OhDelegator
  class Railtie < Rails::Railtie
    initializer 'oh_delegator.orm.setup' do |app|
      ActiveSupport.on_load(:active_record) do
        OhDelegator::ORM.setup(self)
      end
    end
  end
end
