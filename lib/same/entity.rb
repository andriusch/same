# frozen_string_literal: true

module Same
  # {Entity} represents single object in the world. It can be any object including player, enemies, UI elements, score,
  # particle and etc. Each entity has an identifier which helps identify entity type when debugging, but shouldn't
  # be used for anything else
  #
  #     enemies = 10.times.map do
  #       manager.create_entity(:enemy)
  #     end
  #
  # Entities can have one or more {Component} which contain actual properties of the entity.
  #
  #     enemies.each do |enemy|
  #       enemy.add(Position, rand(500), rand(500))
  #       enemy.add(Size.new(10, 10))
  #     end
  #
  # Once component is added it can be accessed by its underscored class name:
  #
  # :call-seq:
  #     enemies[0].position -> #<Position @x=123, @y=456>
  #
  # Note that each entity can only have 1 component of particular class. If the component hasn't been added to entity
  # then it's accessor will return +nil+.
  #
  # Once added components can also be removed:
  #
  #     enemies[0].remove Killable
  #
  # And at last entities can be destroyed if they're no longer needed:
  #
  #     enemies[0].destroy
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
