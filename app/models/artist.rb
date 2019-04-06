# frozen_string_literal: true

class Artist < ApplicationRecord
  belongs_to :user
end
