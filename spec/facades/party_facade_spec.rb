require 'rails_helper'

RSpec.describe PartyFacade do

  it 'exist' do
    user = create(:user)
    facade = PartyFacade.new(user)

    expect(facade).to be_a(PartyFacade)
  end

  describe 'instance methods' do
    before(:each) do
      user = create(:user)
      host = create(:user)
      party = create(:party, name: 'Test Party', user: host, users: [user])
      @facade = PartyFacade.new(user)
    end

    describe '.party_name' do
      it 'returns the name of the party' do
        expect(@facade.party_name).to eq('Test Party')
      end
    end

    describe '.party_code' do
      it 'returns the name of the party' do
        expect(@facade.party_name).to eq('a1b2c3')
      end
    end
  end
end
