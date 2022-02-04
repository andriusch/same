module Same
  class Entity
    attr_reader :manager, :identifier

    def initialize(manager, identifier, &block)
      @manager = manager
      @identifier = identifier
      instance_eval(&block) if block
    end

    def add(type_or_component, ...)
      type, component = type_and_component(type_or_component, ...)
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

    private

    def type_and_component(type_or_component, ...)
      if type_or_component.is_a?(Class)
        [type_or_component, type_or_component.new(...)]
      else
        [type_or_component.class, type_or_component]
      end
    end
  end
end
