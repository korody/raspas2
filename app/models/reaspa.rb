class Reaspa < ActiveRecord::Base

  delegate :author, to: :raspa, prefix: true

  belongs_to :raspa, counter_cache: :citations_count, touch: true
  belongs_to :author

end
