class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :destroy
  has_many :raspas, through: :taggings

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

end
