# frozen_string_literal: true

describe Same::Entity do
  subject(:entity) { described_class.new(manager, :my_entity) }

  let(:other_entity) { described_class.new(manager, :other_entity) }
  let(:manager) { Same::Manager.new }

  let(:selected_component) { stub_component("Selected") }
  let(:used_component) { stub_component("User") }

  describe "#initialize" do
    it { is_expected.to have_attributes(manager: manager, identifier: :my_entity) }

    context "with block" do
      subject(:entity) { described_class.new(manager, :my_entity) { @identifier = :overwritten } }

      it { is_expected.to have_attributes(identifier: :overwritten) }
    end
  end

  describe "#add" do
    before do
      stub_component "Position" do
        attr_reader :x, :y

        def initialize(x, y)
          @x = x
          @y = y
        end
      end
    end

    it "initializes and adds component" do
      entity.add(Position, 15, 27)
      expect(entity.position).to be_a(Position) & have_attributes(x: 15, y: 27)
    end

    it "adds component instance" do
      entity.add(Position.new(15, 27))
      expect(entity.position).to be_a(Position) & have_attributes(x: 15, y: 27)
    end

    it "adds component with multiple words" do
      stub_component("HasSize")
      entity.add(HasSize)
      expect(entity.has_size).to be_a(HasSize)
    end

    it "adds namespaced component" do
      stub_component("UI::Clickable")
      entity.add(UI::Clickable)
      expect(entity.ui_clickable).to be_a(UI::Clickable)
    end
  end

  describe "#remove" do
    before do
      entity.add(selected_component)
      entity.add(used_component)
      other_entity.add(used_component)
    end

    it do
      expect { entity.remove(used_component) }
        .to not_change { manager.entities_with(selected_component) } &
            change { manager.entities_with(used_component) }.to([other_entity])
    end
  end

  describe "#destroy" do
    before do
      entity.add(selected_component)
      entity.add(used_component)
      other_entity.add(used_component)
    end

    it do
      expect { entity.destroy }
        .to change { manager.entities_with(selected_component) }.to([]) &
            change { manager.entities_with(used_component) }.to([other_entity])
    end
  end
end
