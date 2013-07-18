# encoding: utf-8
class Raspa < ActiveRecord::Base

  default_scope { order('raspas.updated_at desc') }
  
  # scope :recent, lambda { order("raspas.created_at desc") }

  scope :raspas_of_scope, lambda { |author| raspas_of(author) }
  scope :reaspas_of_scope, lambda { |author| reaspas_of(author) }
  scope :wall_of, lambda { |author| raspas_of_scope(author).concat(reaspas_of_scope(author)) }



  scope :trending, lambda { |num = nill| where('started_trending > ?', 1.day.ago).
                            order('mentions desc').
                            limit(num) }

  belongs_to :author
  belongs_to :raspa

  belongs_to :origin

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :inverse_reaspas, class_name: "Reaspa", foreign_key: "citation_id"
  has_many :cited, through: :inverse_reaspa, source: :raspa

  has_many :reaspas, dependent: :destroy
  has_many :citations, through: :reaspas, source: :raspa
  # has_many :authors, through: :reaspas

  def self.reaspas_of(author)
    Raspa.joins(:reaspas)
  end

  def self.raspas_of(author)
    Raspa.where(author: author)
  end

  # def self.citations_of(author)
  #   citations_ids = %(SELECT raspa_id FROM reaspas
  #                         WHERE author_id = :author_id)
  #   where("id IN (#{citations_ids}) OR author_id = :author_id",
  #         { author_id: author })
  # end

  # belongs_to :original_raspa,
  #             class_name: 'Raspa',
  #             foreign_key: :raspa_id,
  #             counter_cache: :citacoes_count

  # has_many :citacoes,
  #           class_name: 'Raspa',
  #           foreign_key: :raspa_id


  # def citacao_por(citante)
  #   if self.user == citante
  #     "Esta raspa é mesmo muito boa! Infelizmente não é possível citar sua própria raspa. : /"
  #   elsif self.raspas.where(user_id: citante.id).present?
  #     "Queria eu citar esta raspa mil vezes! Mas só é possível uma vez..."
  #   else
  #     current_user.raspas.create(
  #       status: "reaspa #{raspa.author.name}: #{raspa.status}",
  #       raspa_original: @raspa )
  #     "raspa citada!"          
  #   end
  # end

end
