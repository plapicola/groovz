# frozen_string_literal: true

# Controller for parties information
class PartiesController < ApplicationController
  before_action :require_login
  before_action :reentry

  def index; end

  def new; end

  def show; end
end
