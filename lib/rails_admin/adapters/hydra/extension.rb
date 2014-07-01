module RailsAdmin
  module Adapters
    module Hydra
      module Extension
        extend ActiveSupport::Concern

        # TODO: requirement not confirmed
        #def rails_admin_default_object_label_method
        #  self.new_record? ? "new #{self.class.to_s}" : "#{self.class.to_s} ##{self.id}"
        #end

        # Used in views, took from AR extension
        def safe_send(value)
          if self.attributes.include?(value)
            self.read_attribute(value)
          else
            self.send(value)
          end
        end


        module ClassMethods
          def rails_admin(&block)
            RailsAdmin.config(self, &block)
          end
        end
      end
    end
  end
end
