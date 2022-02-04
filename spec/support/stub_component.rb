# frozen_string_literal: true

module StubComponent
  def stub_component(name, &block)
    Class.new.tap do |klass|
      stub_const(name, klass)
      klass.include Same::Component
      klass.class_eval(&block) if block
    end
  end
end

RSpec.configuration.include StubComponent
