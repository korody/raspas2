class Experience < ActiveRecord::Base

  belongs_to :author
  belongs_to :job

end
