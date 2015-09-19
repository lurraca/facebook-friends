require 'rails_helper'

RSpec.describe Authorization, type: :model do

  let(:user) { User.create(name: 'Example User', email: 'example@user.com' ) }
  let(:authorization) do
    Authorization.create(
        provider: 'facebook',
        uid: "EHWEWKNKWNEKFWNEFKNWAASC>AWDWADAWLDMAWD",
        user: user
    )
  end

  describe 'validations' do
    it { expect(authorization).to be_valid }
    it { expect(authorization).to validate_presence_of(:provider) }
    it { expect(authorization).to validate_inclusion_of(:provider).in_array(['facebook']) }
    it { expect(authorization).to validate_presence_of(:uid) }
    it { expect(authorization).to validate_presence_of(:user) }
  end

  describe 'associations' do
    it { expect(authorization).to belong_to(:user) }
  end
end
