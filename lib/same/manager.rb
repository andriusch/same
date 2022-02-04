module Same
  class Manager
    def initialize
      @store = Hash.new { |h, k| h[k] = [] }
    end

    def create_entity(identifier)
      Entity.new(self, identifier)
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
