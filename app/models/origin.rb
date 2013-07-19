class Origin < ActiveRecord::Base

  belongs_to :author
  has_many :raspas

  has_many :genrings, dependent: :destroy
  has_many :genres, through: :genrings

  def to_param
    "#{id}-#{title.parameterize}"
  end

end
