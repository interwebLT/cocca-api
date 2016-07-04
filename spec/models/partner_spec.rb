RSpec.describe Partner do
  subject(:partner) do
    Partner.new name:     name,
                password: password,
                token:    token
  end

  let(:name)      { 'alpha' }
  let(:password)  { 'password' }
  let(:token)     { '123456789ABCDEF' }

  describe '#valid?' do
    it { is_expected.to be_valid }

    context 'when name is nil' do
      let(:name) { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when password is nil' do
      let(:password) { nil }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#headers' do
    subject { partner.headers }

    let(:expected_headers) {
      {
        'Content-Type'  => 'application/json',
        'Accept'        => 'application/json',
        'Authorization' => 'Token token=123456789ABCDEF'
      }
    }

    it { is_expected.to eq expected_headers }
  end
end
