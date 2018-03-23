class FormatSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description
end
