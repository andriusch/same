describe Same::Manager do
  subject(:manager) { described_class.new }

  describe '#create_entity' do
    subject(:entity) { manager.create_entity(:manager_entity) }

    it { is_expected.to be_a(Same::Entity).and have_attributes(manager: manager, identifier: :manager_entity) }
  end

  describe '#entities_with' do
    subject { manager.entities_with(selector) }
    let(:selector) { Selected }

    let!(:selected) { manager.create_entity(:selected) }
    let!(:empty) { manager.create_entity(:empty) }

    before do
      stub_component('Selected')

      selected.add(Selected)
    end

    it { is_expected.to eq([selected]) }
  end
end
