# frozen_string_literal: true

class UserOnboardJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @user = User.find(args[0])
    @user.update_musical_taste
  end
end
