require 'test_helper'

describe UpdateDomainContactQuery do
  before do
    update_domain_contact audit_time: audit_time

    update_domain_contact audit_time: audit_time, partner: EXCLUDED_PARTNER
    create :excluded_partner
  end

  let(:since) { '2015-03-06 14:00'.in_time_zone }
  let(:up_to) { '2015-03-06 14:30'.in_time_zone }

  describe :run do
    subject { UpdateDomainContactQuery.run since: since, up_to: up_to  }

    context :when_record_created_within_period do
      let(:audit_time) { up_to }

      specify { subject.count.must_equal 1 }
      specify { subject.first['domain'].must_equal 'domains.ph' }
      specify { subject.first['handle'].must_equal 'domain_admin' }
      specify { subject.first['type'].must_equal 'admin' }
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
