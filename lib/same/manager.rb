# frozen_string_literal: true

module Same
  # Manager is a database mapping which entities contain which components and thus allows finding entities by component
  # class.
  # :call-seq:
  #     manager = Same::Manager.new
  #     manager.create_entity(:player) do
  #       add PlayerControls
  #       add Position, 12, 13
  #     end
  #     manager.create_entity(:enemy) do
  #       add Position, 60, 70
  #     end
  #
  #     manager.entities_with(Position) -> [player, enemy]
  #     manager.entities_with(PlayerControls & Position) -> [player]
  class Manager
    def initialize
      @store = Hash.new { |h, k| h[k] = [] }
    end

    def create_entity(...)
      Entity.new(self, ...)
    end

    def entities_with(selector)
      selector.entities(@store)
    end

    # @private
    def _register_component(entity, type)
      @store[type] << entity
    end

    # @private
    def _unregister_component(entity, type)
      @store[type].delete(entity)
    end

    # @private
    def _unregister_entity(entity)
      @store.each_value { |entities| entities.delete(entity) }
    end
  end
end
