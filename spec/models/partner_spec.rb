RSpec.describe Partner do
  subject do
    Partner.new name:     name,
                password: password
  end

  let(:name)      { 'alpha' }
  let(:password)  { 'password' }

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
end
