class Relationship < ActiveRecord::Base

  belongs_to :author, counter_cache: :idols_count
  belongs_to :idol, class_name: "Author", counter_cache: :fans_count

end
