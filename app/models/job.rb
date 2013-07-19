class Job < ActiveRecord::Base

  has_many :experience, dependent: :destroy

  has_many :author, through: :experience

end
