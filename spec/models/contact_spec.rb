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

  let(:client)  { double('client') }

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

  describe '#as_json' do
    subject do
      contact = Contact.new partner:            partner,
                            handle:             handle,
                            local_name:         local_name,
                            local_street:       local_street,
                            local_city:         local_city,
                            local_country_code: local_country_code,
                            voice:              voice,
                            email:              email,

                            local_organization: local_organization,
                            local_street2:      local_street2,
                            local_street3:      local_street3,
                            local_state:        local_state,
                            local_postal_code:  local_postal_code,

                            voice_ext:          voice_ext,
                            fax:                fax,
                            fax_ext:            fax_ext,

                            name:               name,
                            organization:       organization,
                            street:             street,
                            street2:            street2,
                            street3:            street3,
                            city:               city,
                            state:              state,
                            postal_code:        postal_code,
                            country_code:       country_code

      contact.as_json
    end

    let(:local_organization)  { 'Local Organization' }
    let(:local_street2)       { 'Local Street 2' }
    let(:local_street3)       { 'Local Street 3' }
    let(:local_state)         { 'Local State' }
    let(:local_postal_code)   { 1235 }

    let(:voice_ext)           { 1234 }
    let(:fax)                 { '+63.1234568' }
    let(:fax_ext)             { 1235 }

    let(:name)                { 'Contact' }
    let(:organization)        { 'Organization' }
    let(:street)              { 'Street' }
    let(:street2)             { 'Street 2' }
    let(:street3)             { 'Street 3' }
    let(:city)                { 'City' }
    let(:state)               { 'State' }
    let(:postal_code)         { 1234 }
    let(:country_code)        { 'PH' }

    let(:expected_json) {
      {
        handle: 'contact123',
        name: 'Contact',
        organization: 'Organization',
        street: 'Street',
        street2:  'Street 2',
        street3:  'Street 3',
        city: 'City',
        state:  'State',
        postal_code:  1234,
        country_code: 'PH',
        local_name: 'Local Contact',
        local_organization: 'Local Organization',
        local_street: 'Local Street',
        local_street2:  'Local Street 2',
        local_street3:  'Local Street 3',
        local_city: 'Local City',
        local_state:  'Local State',
        local_postal_code:  1235,
        local_country_code: 'RP',
        voice:  '+63.1234567',
        voice_ext:  1234,
        fax:  '+63.1234568',
        fax_ext:  1235,
        email:  'contact@test.ph'
      }
    }

    it { is_expected.to eql expected_json }
  end

  describe '#save' do
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

  describe '#update' do
    context 'when EPP command fails' do
      before do
        expect(client).to receive(:update).and_return 'contacts/update_failed_response'.epp
        expect(EPP::Client).to receive(:new) { client }
      end

      it { expect(subject.update).to eql false }
    end
  end
end
