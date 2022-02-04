module Same
  class Entity
    attr_reader :manager, :identifier

    def initialize(manager, identifier)
      @manager = manager
      @identifier = identifier
    end

    def add(type, ...)
      component = type.new(...)
      instance_variable_set("@#{type.identifier}", component)
      @manager._register_component(self, type)
      self
    end

    def remove(type)
      @manager._unregister_component(self, type)
    end

    def destroy
      @manager._unregister_entity(self)
    end
  end
end
