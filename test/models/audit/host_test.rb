require 'test_helper'

describe Audit::Host do
  subject { create :audit_host }

  describe :associations do
    specify { subject.master.wont_be_nil }
  end

  describe :as_json do
    let(:expected_json) {
      {
        partner:  'alpha',
        name:     'ns5.domains.ph'
      }
    }

    specify { subject.as_json.must_equal expected_json }
  end
end
