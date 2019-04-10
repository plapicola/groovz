class TrackStatusSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status
end
