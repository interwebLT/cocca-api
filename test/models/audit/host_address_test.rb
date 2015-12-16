require 'test_helper'

describe Audit::HostAddress do
  describe :associations do
    subject { create :create_host_address }

    specify { subject.master.wont_be_nil }
  end
end
