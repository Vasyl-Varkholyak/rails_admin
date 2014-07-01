module RailsAdmin
  module Adapters
    module Hydra
      class Property
        attr_reader :property, :model

        def initialize(property, model)
          @property = property
          @model = model
        end

        def name
          property.name.to_sym
        end

        def pretty_name
          property.name.to_s.tr('_', ' ').capitalize
        end

        def type
          property.type
        end

        def length
          property.limit
        end

        def nullable?
          property.null
        end

        def serial?
          property.primary
        end

        def association?
          false
        end

        def read_only?
          false
        end
      end
    end
  end
end
