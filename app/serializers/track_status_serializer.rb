# frozen_string_literal: true

class TrackStatusSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status
end
