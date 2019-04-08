class DevicesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
