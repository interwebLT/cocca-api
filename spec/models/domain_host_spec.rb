module EPP
  module Domain
    class Command; end
    class Update < Command
      attr_reader :chg
    end
  end
end

RSpec.describe DomainHost do
  let(:client) { double('client') }

  describe '#destroy' do
    subject do
      domain_host = DomainHost.new domain: 'domain.ph', name: 'ns5.domains.ph'

      domain_host.destroy
    end

    before do
      expect(client).to receive(:update).and_return('domains/domain.ph/update_response'.epp)

      expect(EPP::Client).to receive(:new) { client }
    end

    it { is_expected.to eql true }
  end
end
