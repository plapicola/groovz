# frozen_string_literal: true

class DevicesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
