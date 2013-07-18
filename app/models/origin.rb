class Origin < ActiveRecord::Base

  belongs_to :author
  has_many :raspas

end
