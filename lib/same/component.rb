module Same
  module Component
    extend ActiveSupport::Concern

    included do
      @identifier = name.underscore
      singleton_class.attr_reader :identifier
      Same::Entity.attr_reader @identifier
    end
  end
end
