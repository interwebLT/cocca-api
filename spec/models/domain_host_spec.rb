module EPP
  module Domain
    class Command; end
    class Update < Command
      attr_reader :chg
    end
  end
end

RSpec.describe DomainHost do
  subject(:domain_host) { DomainHost.new partner: partner, domain: domain, name: name }

  let(:client) { double('client') }

  let(:partner) { 'alpha' }
  let(:domain)  { 'domain.ph' }
  let(:name)    { 'ns5.domains.ph' }

  describe '#valid?' do
    subject { DomainHost.new partner: partner, domain: domain, name: name }

    it { is_expected.to be_valid }

    context 'when domain is nil' do
      let(:domain) { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when name is nil' do
      let(:name) { nil }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#destroy' do
    subject { domain_host.destroy }

    before do
      expect(client).to receive(:update).and_return('domains/domain.ph/update_response'.epp)

      expect(EPP::Client).to receive(:new) { client }
    end

    it { is_expected.to eql true }
  end

  describe '#as_json' do
    subject { domain_host.as_json }

    let(:expected_json) {
      {
        id:   1,
        name: 'ns5.domains.ph'
      }
    }

    it { is_expected.to eql expected_json }
  end
end
