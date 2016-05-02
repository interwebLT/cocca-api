module EPP
  module Contact
    class Command; end
    class Update < Command
      attr_reader :chg
    end
  end
end

RSpec.describe Contact do
  subject do
    Contact.new partner:            partner,
                handle:             handle,
                local_name:         local_name,
                local_street:       local_street,
                local_city:         local_city,
                local_country_code: local_country_code,
                voice:              voice,
                email:              email
  end

  let(:partner)             { 'alpha' }
  let(:handle)              { 'contact123' }
  let(:local_name)          { 'Local Contact' }
  let(:local_street)        { 'Local Street' }
  let(:local_city)          { 'Local City' }
  let(:local_country_code)  { 'RP' }
  let(:voice)               { '+63.1234567' }
  let(:email)               { 'contact@test.ph' }

  describe '#valid?' do
    it { is_expected.to be_valid }

    context 'when subject blank' do
      subject { Contact.new }

      it { is_expected.not_to be_valid }
    end

    context 'when partner is nil' do
      let(:partner)  { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when handle is nil' do
      let(:handle)  { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when local_name is nil' do
      let(:local_name)  { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when local_street is nil' do
      let(:local_street)  { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when local_city is nil' do
      let(:local_city)  { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when local_country_code is nil' do
      let(:local_country_code)  { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when voice is nil' do
      let(:voice)  { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when email is nil' do
      let(:email)  { nil }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#save' do
    let(:client)  { double('client') }

    context 'when required fields present' do
      before do
        expect(client).to receive(:create).and_return 'contacts/create_response'.epp
        expect(EPP::Client).to receive(:new) { client }
      end

      it { expect(subject.save).to eql true }
    end

    context 'when required fields missing' do
      it { expect(Contact.new.save).to eql false }
    end

    context 'when EPP command fails' do
      before do
        expect(client).to receive(:create).and_return 'contacts/create_failed_response'.epp
        expect(EPP::Client).to receive(:new) { client }
      end

      it { expect(subject.save).to eql false }
    end
  end
end
