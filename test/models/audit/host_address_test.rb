require 'test_helper'

describe Audit::HostAddress do
  describe :associations do
    subject { create :create_host_address }

    specify { subject.master.wont_be_nil }
  end

  describe :as_json do
    subject { build :create_host_address }

    let(:expected_json) {
      {
        host:     'ns5.domains.ph',
        address:  '123.123.123.001',
        type:     'v4'
      }
    }

    specify { subject.as_json.must_equal expected_json }
  end
end
