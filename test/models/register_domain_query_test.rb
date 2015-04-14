require 'test_helper'

describe RegisterDomainQuery do
  before do
    create_domain audit_time: audit_time
    create_domain audit_time: audit_time, partner: EXCLUDED_PARTNER

    create :excluded_partner
  end

  let(:since) { '2015-03-06 14:00'.in_time_zone }
  let(:up_to) { '2015-03-06 14:30'.in_time_zone }

  describe :run do
    subject { RegisterDomainQuery.run since: since, up_to: up_to  }

    context :when_record_created_within_period do
      let(:audit_time) { up_to }

      specify { subject.count.must_equal 1 }
      specify { subject.first['partner'].must_equal 'alpha' }
      specify { subject.first['currency_code'].must_equal 'USD' }
      specify { subject.first['domain'].must_equal 'domains.ph' }
      specify { subject.first['period'].must_equal '1' }
      specify { subject.first['registrant_handle'].must_equal 'registrant' }
      specify { subject.first['registered_at'].wont_be_nil }
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
