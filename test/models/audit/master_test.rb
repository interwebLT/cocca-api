require 'test_helper'

describe Audit::Master do
  describe :transactions do
    subject { Audit::Master.transactions since: since, up_to: up_to }

    let(:since) { '2015-05-29 2:00 PM'.in_time_zone }
    let(:up_to) { '2015-05-29 2:30 PM'.in_time_zone }

    context :when_within_range do
      before do
        create_domain audit_time: since
      end

      specify { subject.count.must_equal 1 }
    end

    context :when_with_excluded do
      before do
        create_domain audit_time: since, partner: EXCLUDED_PARTNER
        create :excluded_partner
      end

      specify { subject.must_be_empty }
    end

    context :when_at_up_to do
      before do
        create_domain audit_time: up_to
      end

      specify { subject.must_be_empty }
    end
  end

  describe :associations do
    subject { create :audit_master }

    before do
      create_domain audit_transaction: subject.audit_transaction
    end

    specify { subject.domains.count.must_equal 1 }
  end
end
