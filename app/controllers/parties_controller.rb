# frozen_string_literal: true

# Controller for parties information
class PartiesController < ApplicationController
  before_action :require_login
  before_action :reentry

  def index; end

  def new; end

  def create
    if Party.find_by(join_party_params)
      redirect_to party_path
    else
      render :new
    end
  end

  def show; end

  private

  def join_party_params
    params.permit(:code)
  end
end
