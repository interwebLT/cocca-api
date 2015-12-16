require 'test_helper'

describe HostAddressQuery do
  before do
    create :excluded_partner

    host_address = create :create_host_address
    host_address.master.update audit_time: audit_time

    excluded_host_address = create :create_host_address
    excluded_host_address.master.update audit_time: audit_time, audit_user: EXCLUDED_PARTNER
  end

  let(:since) { '2015-03-04 14:00'.in_time_zone }
  let(:up_to) { '2015-03-04 14:30'.in_time_zone }

  describe :all do
    subject { HostAddressQuery.run since: since, up_to: up_to, audit_operation: 'I'  }

    context :when_record_created_within_period do
      let(:audit_time) { up_to }

      specify { subject.count.must_equal 1 }
      specify { subject.first['host'].must_equal 'ns5.domains.ph' }
      specify { subject.first['address'].must_equal '123.123.123.001' }
      specify { subject.first['type'].must_equal 'v4' }
    end

    context :when_record_created_before_period do
      let(:audit_time) { since - 1.day }

      specify { subject.must_be_empty }
    end

    context :when_record_created_after_period do
      let(:audit_time) { since + 1.day }

      specify { subject.must_be_empty }
    end

    context :when_record_created_at_the_end_of_last_period do
      let(:audit_time) { since }

      specify { subject.must_be_empty }
    end
  end
end
