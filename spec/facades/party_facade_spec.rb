require 'rails_helper'

RSpec.describe PartyFacade do

  it 'exist' do
    user = create(:user)
    facade = PartyFacade.new(user)

    expect(facade).to be_a(PartyFacade)
  end
end
