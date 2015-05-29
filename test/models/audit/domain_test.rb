require 'test_helper'

describe Audit::Domain do
  describe :associations do
    subject { create_domain }

    specify { subject.master.wont_be_nil }
  end
end
