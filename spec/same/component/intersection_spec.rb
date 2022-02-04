# frozen_string_literal: true

describe Same::Component::Intersection do
  subject(:intersection) { described_class.new(Selected, Used) }

  before do
    stub_component("Selected")
    stub_component("Used")
    stub_component("Killed")
  end

  describe "#entities" do
    subject { intersection.entities(store) }

    let(:store) { {Selected => [1, 2, 4, 8, 16, 32], Used => [1, 2, 3, 5, 8, 13, 21, 34], Killed => [1, 2, 4, 6]} }

    it { is_expected.to eq([1, 2, 8]) }

    context "when chained with another intersection" do
      let(:intersection) { super() & Killed }

      it { is_expected.to eq([1, 2]) }
    end
  end
end
