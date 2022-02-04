# frozen_string_literal: true

describe Same::Manager do
  subject(:manager) { described_class.new }

  describe "#create_entity" do
    subject(:entity) { manager.create_entity(:manager_entity) }

    it { is_expected.to be_a(Same::Entity) & have_attributes(manager: manager, identifier: :manager_entity) }
  end

  describe "#entities_with" do
    subject { manager.entities_with(selector) }
    let(:selector) { Selected }

    let!(:selected_used) { manager.create_entity(:selected_used) }
    let!(:selected) { manager.create_entity(:selected) }
    let!(:empty) { manager.create_entity(:empty) }

    before do
      stub_component("Selected")
      stub_component("Used")

      selected.add(Selected)
      selected_used.add(Selected)
      selected_used.add(Used)
    end

    it { is_expected.to contain_exactly(selected_used, selected) }

    context "when searching for Selected & Used" do
      let(:selector) { Selected & Used }

      it { is_expected.to contain_exactly(selected_used) }
    end
  end
end
