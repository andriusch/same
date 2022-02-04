# frozen_string_literal: true

module Same
  module Component
    # Represents intersection of 2 {Component} classes. Useful for searching for entities that have both components.
    class Intersection
      include Component::Composable

      attr_reader :left, :right

      def initialize(left, right)
        @left = left
        @right = right
      end

      def entities(store)
        @left.entities(store) & @right.entities(store)
      end
    end
  end
end
