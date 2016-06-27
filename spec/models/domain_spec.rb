RSpec.describe Domain do
  let(:client)  { double 'client' }

  subject(:domain) do
    Domain.new  name:               name,
                partner:            partner,
                registrant_handle:  registrant_handle
  end

  let(:name)              { 'domain.ph' }
  let(:partner)           { 'alpha' }
  let(:registrant_handle) { 'contact' }

  describe '#valid?' do
    it { is_expected.to be_valid }

    context 'when name is nil' do
      let(:name)  { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when registrant_handle is nil' do
      let(:registrant_handle) { nil }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#update_authcode' do
    subject { domain.update_authcode 'ABC123' }

    before do
      expect(client).to receive(:update).and_return 'domains/domain.ph/update_authcode_response'.epp
      expect(EPP::Client).to receive(:new) { client }
    end

    it { is_expected.to be true }
  end

  describe '#exists?' do
    subject { Domain.new.exists? name: name }

    context 'when domain exists' do
      let(:name) { 'domain.ph' }

      before do
        expect(client).to receive(:check).and_return 'domains/domain.ph/check_response'.epp
        expect(EPP::Client).to receive(:new) { client }
      end

      it { is_expected.to be true }
    end

    context 'when domain available' do
      let(:name) { 'available.ph' }

      before do
        expect(client).to receive(:check).and_return 'domains/available.ph/check_response'.epp
        expect(EPP::Client).to receive(:new) { client }
      end

      it { is_expected.to be false }
    end
  end
end
