RSpec.describe Host do
  let(:client) { double 'client' }

  describe '#exists?' do
    subject { Host.new.exists? name: name }

    context 'when host exists' do
      let(:name)  { 'ns5.domains.ph' }

      before do
        expect(client).to receive(:check).and_return 'hosts/ns5.domains.ph/check_response'.epp
        expect(EPP::Client).to receive(:new) { client }
      end

      it { is_expected.to be true }
    end

    context 'when host exists' do
      let(:name) { 'dne.domains.ph' }

      before do
        expect(client).to receive(:check).and_return 'hosts/dne.domains.ph/check_response'.epp
        expect(EPP::Client).to receive(:new) { client }
      end

      it { is_expected.to be false }
    end
  end
end
