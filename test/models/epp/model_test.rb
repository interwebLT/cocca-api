require 'test_helper'

describe EPP::Model do
  subject { EPP::Model.new params }

  let(:partner) { create :partner }

  describe :client do
    context :when_partner_exists do
      let(:params) {
        {
          partner: partner.name
        }
      }

      specify { subject.client.host.must_equal 'test.host' }
      specify { subject.client.tag.must_equal 'alpha' }
      specify { subject.client.passwd.must_equal 'password' }
    end

    context :when_partner_does_not_exist do
      let(:params) {
        {
          partner: 'doesnotexist'
        }
      }

      specify { subject.client.host.must_equal 'test.host' }
      specify { subject.client.tag.must_equal 'test' }
      specify { subject.client.passwd.must_equal 'test_password' }
    end

    context :when_partner_nil do
      let(:params) {
        {
          partner: nil
        }
      }

      specify { subject.client.host.must_equal 'test.host' }
      specify { subject.client.tag.must_equal 'test' }
      specify { subject.client.passwd.must_equal 'test_password' }
    end
  end
end
