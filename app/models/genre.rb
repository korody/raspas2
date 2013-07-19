class Genre < ActiveRecord::Base

  has_many :genrings, dependent: :destroy
  has_many :origins, through: :genrings

end
