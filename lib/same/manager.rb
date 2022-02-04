# frozen_string_literal: true

module Same
  # Manager is a database mapping which entities contain which components and thus allows finding entities by component
  # class.
  # :call-seq:
  #     manager = Same::Manager.new
  #     manager.create_entity(:player) do
  #       add PlayerControls
  #     end
  #
  #     manager.entities_with(PlayerControls) -> [player]
  class Manager
    def initialize
      @store = Hash.new { |h, k| h[k] = [] }
    end

    def create_entity(...)
      Entity.new(self, ...)
    end

    def entities_with(type)
      @store[type]
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
