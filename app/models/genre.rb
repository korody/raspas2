class Genre < ActiveRecord::Base

  has_many :genrings, dependent: :destroy
  has_many :origins, through: :genrings

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

end
