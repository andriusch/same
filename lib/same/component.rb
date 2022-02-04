# frozen_string_literal: true

require_relative "component/composable"
require_relative "component/intersection"

module Same
  # This module should be included in every component in your application.
  #
  # Components are data holders. Each component class defines a small set of data that it holds. Then entities can
  # have instance of components attached to them.
  #
  # Ideally components should contain only several fields. Remember
  # entities as many types of components as they need, so small components help keep things flexible.
  #
  # Components shouldn't include any business logic. Any methods defined in a component should be there only to allow
  # different types of accessing data.
  #
  # Sometimes components might not have any additional data, mere presence of a component on an entity can indicate
  # some behavior (e.g. +Killable+ component which indicates that entity can be killed).
  #
  # Example component:
  #     class Motion
  #       include Same::Component
  #       attr_reader :speed
  #
  #       def initialize(speed)
  #         @speed = speed
  #       end
  #     end
  #
  #     entity.add Motion, 10
  module Component
    extend ActiveSupport::Concern

    included do
      @identifier = name.underscore
      singleton_class.attr_reader :identifier
      Same::Entity.attr_reader @identifier
    end

    # Class methods for {Component}.
    module ClassMethods
      include Composable

      def entities(store)
        store[self]
      end
    end
  end
end
