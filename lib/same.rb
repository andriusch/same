# frozen_string_literal: true

require "active_support"
require "active_support/core_ext"

require_relative "same/manager"
require_relative "same/entity"
require_relative "same/component"
require_relative "same/version"

# Getting started:
# 1. Create a component
#    class Position
#      include Same::Component
#      attr_reader :x, :y
#
#      def initialize(x, y)
#        @x = x
#        @y = y
#      end
#    end
# 2. Initialize manager
#     manager = Same::Manager.new
# 3. Create entity
#     player = manager.create_entity(:player) do
#       add Position, x, y
#     end
module Same
end
