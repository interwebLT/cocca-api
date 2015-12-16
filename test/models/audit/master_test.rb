require 'test_helper'

describe Audit::Master do
  describe :transactions do
    subject { Audit::Master.transactions since: since, up_to: up_to }

    let(:since) { '2015-05-29 2:00 PM'.in_time_zone }
    let(:up_to) { '2015-05-29 2:30 PM'.in_time_zone }

    context :when_within_range do
      before do
        domain = create :register_domain
        domain.master.update audit_time: since
      end

      specify { subject.count.must_equal 1 }
    end

    context :when_with_excluded do
      before do
        domain = create :register_domain
        domain.master.update audit_time: since, audit_user: EXCLUDED_PARTNER

        create :excluded_partner
      end

      specify { subject.must_be_empty }
    end

    context :when_at_up_to do
      before do
        domain = create :register_domain
        domain.master.update audit_time: up_to
      end

      specify { subject.must_be_empty }
    end

    context :when_transaction_excluded do
      before do
        domain = create :register_domain
        domain.master.update audit_time: since

        create :tr_id, tr_id: domain.audit_transaction
      end

      specify { subject.must_be_empty }
    end
  end

  describe :associations do
    subject { create :audit_master }

    before do
      create :audit_domain,   audit_transaction: subject.audit_transaction
      create :audit_contact,  audit_transaction: subject.audit_transaction
      create :audit_host,     audit_transaction: subject.audit_transaction
    end

    specify { subject.domains.count.must_equal 1 }
    specify { subject.contacts.count.must_equal 1 }
    specify { subject.hosts.count.must_equal 1 }
  end

  describe :latest_time do
    subject { Audit::Master.latest_time }

    before do
      create :audit_master, audit_time: '2015-05-29 3:00 PM'.in_time_zone
      create :audit_master, audit_time: '2015-05-29 3:30 PM'.in_time_zone
    end

    specify { subject.must_equal '2015-05-29 3:30:01 PM'.in_time_zone }
  end
end
