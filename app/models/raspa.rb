# encoding: utf-8
class Raspa < ActiveRecord::Base
  attr_accessor :original_author, :origin_name
  attr_writer :origin_name

  validates_presence_of :author

  before_validation :normalize
  before_save :assign_origin

  default_scope { order('raspas.updated_at desc') }
  
  # scope :recent, lambda { order("raspas.created_at desc") }

  scope :raspas_of_scope, lambda { |author| raspas_of(author) }
  scope :reaspas_of_scope, lambda { |author| reaspas_of(author) }
  scope :wall_of, lambda { |author| raspas_of_scope(author).concat(reaspas_of_scope(author)) }

  scope :trending, lambda { |num = nill| where('started_trending > ?', 1.day.ago).
                            order('mentions desc').
                            limit(num) }

  belongs_to :author
  belongs_to :origin
  belongs_to :raspa

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :inverse_reaspas, class_name: "Reaspa", foreign_key: "citation_id"
  has_many :cited, through: :inverse_reaspa, source: :raspa

  has_many :reaspas, dependent: :destroy
  has_many :citations, through: :reaspas, source: :raspa
  has_many :citers, through: :reaspas, source: :author

  def normalize
    if quote
      self.quote = quote.gsub('"', '').gsub("'", '`').gsub("\r\n", ' ')
    end  
  end

  def self.reaspas_of(author)
    Raspa.joins(:reaspas)
  end

  def self.raspas_of(author)
    Raspa.where(author: author)
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def assign_origin
    if origin_name
      origin = Origin.first_or_create!(title: origin_name.strip)
      # if origin
      #   if origin.user_id.blank?
      #     origin.update_attributes(user_id: user.id)
      #   end
      #   if !origin_type.blank?
      #     origin.update_attributes(type: origin_type)
      #   else
      #     if origin.type.blank?
      #       origin.update_attributes(type: 'Other')
      #     end
      #   end  
      #   if !author_name.blank?
      #     origin.update_attributes(author_id: @some_author.id)
      #   end
      # end
      self.origin_id = origin ? origin.id : 0
    end
  end

end
