class Job < ActiveRecord::Base

  has_many :experience, dependent: :destroy

  has_many :author, through: :experience

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

end
