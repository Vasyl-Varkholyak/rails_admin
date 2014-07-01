require 'rails_admin/config/fields/base'
require 'rails_admin/i18n_support'

module RailsAdmin
  module Config
    module Fields
      module Types
        class DateTime < RailsAdmin::Config::Fields::Types::Datetime
          RailsAdmin::Config::Fields::Types::register(self)
        end
      end
    end
  end
end
