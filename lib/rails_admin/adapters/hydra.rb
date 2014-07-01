require 'rails_admin/adapters/hydra/abstract_object'

module RailsAdmin
  module Adapters
    module Hydra

      def new(params = { })
        AbstractObject.new(model.new(params))
      end

      def get(id)
        if object = model.find(id)
          AbstractObject.new object
        else
          nil
        end
      end

      def scoped
        model.scoped
      end

      def associations
        # We don't support associations
        []
      end

      def first(options = { }, scope = nil)
        all(options, scope).first
      end

      def all(options = { }, scope = nil)
        # we wil use array of records to query on them with ruby
        scope = model.all
        scope = model.order_collection(scope, options[:sort], options[:sort_reverse]) if options[:sort]
        scope = Kaminari.paginate_array(scope) if ((options[:page] && options[:per])) || options[:all]
        if (options[:page] && options[:per])
          scope = scope.send(Kaminari.config.page_method_name, options[:page]).per(options[:per])
        end
        scope
      end

      def count(options = { }, scope = nil)
        model.all.count
      end

      def destroy(objects)
        Array.wrap(objects).each &:destroy
      end

      def primary_key
        model.primary_key
      end

      def properties
        model.columns.reject { |c| c.type.blank? }.map do |property|
          {
              :name => property.name.to_sym,
              :pretty_name => property.name.to_s.tr('_', ' ').capitalize,
              :length => property.limit,
              :nullable? => property.null,
              :serial? => property.primary,
          }.merge(type_lookup(property))
        end
      end

      def table_name
        model.table_name
      end

      def encoding
        Rails.configuration.database_configuration[Rails.env]['encoding']
      end

      def embedded?
        false
      end

      def adapter_supports_joins?
        false
      end

      private

      def type_lookup(property)
        { :type => property.type }
      end

    end
  end
end
