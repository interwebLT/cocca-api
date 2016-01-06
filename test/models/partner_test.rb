require 'test_helper'

describe Partner do
  describe :valid? do
    subject { build :partner }

    specify { subject.valid?.must_equal true }
    specify { subject.name = nil; subject.valid?.must_equal false }
  end
end
