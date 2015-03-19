require 'test_helper'

describe UpdateDomainQuery do
  before do
    update_domain audit_time: audit_time
  end

  let(:since) { '2015-03-06 14:00'.in_time_zone }
  let(:up_to) { '2015-03-06 14:30'.in_time_zone }

  describe :run do
    subject { UpdateDomainQuery.run since: since, up_to: up_to  }

    context :when_record_created_within_period do
      let(:audit_time) { up_to }

      specify { subject.count.must_equal 1 }
      specify { subject.first['domain'].must_equal 'domains.ph' }
      specify { subject.first['registrant'].must_equal 'registrant' }
      specify { subject.first['client_hold'].must_equal false }
      specify { subject.first['client_delete_prohibited'].must_equal false }
      specify { subject.first['client_renew_prohibited'].must_equal false }
      specify { subject.first['client_transfer_prohibited'].must_equal false }
      specify { subject.first['client_update_prohibited'].must_equal false }
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
