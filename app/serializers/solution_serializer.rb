class SolutionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :created_at, :varient, :format_id

  has_many :assets
end
