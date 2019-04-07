# frozen_string_literal: true

module Host
  # Controller for displaying party creation and show for host users
  class PartiesController < ApplicationController
    before_action :require_login
    before_action :reentry, except: [:destroy, :show]

    def show
      render locals: {facade: PartyFacade.new(current_user)}
    end

    def edit
      party = Party.generate_party(current_user)
      render locals: {party: party}
    end

    def update
      party = current_user.party
      if party.update(party_params)
        redirect_to host_party_path
      else
        flash[:error] = "Something went wrong, please try again."
        render :edit, locals: {
          party: party
        }
      end
    end

    def destroy
      party = current_user.party
      party.users.update(party: nil)
      party.destroy
      redirect_to root_path
    end

    private

    def party_params
      params.permit(:name)
    end
  end
end
