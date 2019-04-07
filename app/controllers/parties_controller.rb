# frozen_string_literal: true

# Controller for parties information
class PartiesController < ApplicationController
  before_action :require_login
  before_action :reentry, except: [:show, :delete]

  def index; end

  def new; end

  def create
    party = Party.find_by(join_party_params)
    if party
      current_user.update(party: party)
      redirect_to party_path
    else
      render :new
    end
  end

  def show
    render locals: {facade: PartyFacade.new(current_user)}
  end

  def delete
    current_user.update(party: nil)
    redirect_to root_path
  end

  private

  def join_party_params
    params.permit(:code)
  end
end
