# frozen_string_literal: true

module Same
  module Component
    # Adds & method to compose component classes into intersections.
    module Composable
      def &(other)
        Intersection.new(self, other)
      end
    end
  end
end
