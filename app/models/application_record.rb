# frozen_string_literal: true

# Class for common ActiveRecord methods
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
