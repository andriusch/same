# frozen_string_literal: true

describe Same::Component::Composable do
  describe ".&" do
    subject { selected & used }
    let(:selected) { Class.new { extend Same::Component::Composable } }
    let(:used) { Class.new { extend Same::Component::Composable } }

    it { is_expected.to be_a(Same::Component::Intersection) & have_attributes(left: selected, right: used) }
  end
end
