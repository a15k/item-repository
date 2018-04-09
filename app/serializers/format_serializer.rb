class FormatSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :identifier, :description
end
