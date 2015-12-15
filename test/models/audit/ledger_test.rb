require 'test_helper'

describe Audit::Ledger do
  describe :transfer_type? do
    subject { create :transfer_ledger }

    specify { subject.transfer? }
  end
end
