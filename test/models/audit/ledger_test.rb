require 'test_helper'

describe Audit::Ledger do
  describe :transfer? do
    subject { create :transfer_ledger }

    specify { subject.transfer? }
  end

  describe :renew? do
    subject { create :renew_ledger }

    specify { subject.renew? }
  end

  describe :register? do
    subject { create :register_ledger }

    specify { subject.register? }
  end
end
