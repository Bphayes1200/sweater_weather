class SalariesSerializer
  include JSONAPI::Serializer
  attributes :job, :percentile_25, :percentile_75
end
