class Reaspa < ActiveRecord::Base

  belongs_to :raspa, counter_cache: :citations_count, touch: true
  belongs_to :author

end
