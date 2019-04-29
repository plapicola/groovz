# frozen_string_literal: true

# Controller for parties information
class PartiesController < ApplicationController
  before_action :require_login
  before_action :reentry, except: %i[show delete]
  before_action :bounce_user, only: :show

  def index; end

  def new; end

  def create
    party = Party.find_by(join_party_params)
    if party
      current_user.update(party: party)
      UpdatePlaylistJob.perform_later(party.id)
      redirect_to party_path
    else
      render :new
    end
  end

  def show
    render locals: { facade: PartyFacade.new(current_user) }
  end

  def delete
    current_user.update(party: nil)
    redirect_to root_path
  end

  private

  def bounce_user
    redirect_to root_path unless current_user.party
  end

  def join_party_params
    params[:code]&.downcase!
    params.permit(:code)
  end
end
