# frozen_string_literal: true

describe Same::Component do
  before do
    stub_component("Selected")
    stub_component("Used")
  end

  describe ".entities" do
    subject { Selected.entities(store) }

    let(:store) { {Selected => [1, 2, 4, 8, 16, 32], Used => [1, 2, 3, 5, 8, 13, 21, 34]} }

    it { is_expected.to eq([1, 2, 4, 8, 16, 32]) }
  end
end
