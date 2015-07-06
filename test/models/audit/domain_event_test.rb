require 'test_helper'

describe Audit::DomainEvent do
  describe :period do
    context :when_period_in_years do
      subject { create :audit_domain_event }

      specify { subject.period.must_equal 1 }
    end

    context :when_period_in_months do
      subject { create :audit_domain_event, term_length: 12, term_units: 'MONTH' }

      specify { subject.period.must_equal 1 }
    end
  end
end
