class SolutionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :created_at, :varient
  has_many :assets
  attribute :format_identifier do |object|
    object.format.identifier
  end
end
