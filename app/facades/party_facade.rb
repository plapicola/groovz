class PartyFacade

  def initialize(user)
    @party = Party.find_by(users: user)
  end

  def party_name
    @party.name
  end

  def party_code
    @party.code
  end
end
