require 'test_helper'

describe Audit::DomainHost do
  describe :as_json do
    subject { create :create_domain_host }

    let(:expected_json) {
      {
        domain: 'domains.ph',
        host:   'ns5.domains.ph'
      }
    }

    specify { subject.as_json.must_equal expected_json }
  end
end
