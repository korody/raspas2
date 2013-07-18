class Author < ActiveRecord::Base
  has_secure_password #(validations: false)

  has_many :raspas
  has_many :origins

  has_many :relationships, dependent: :destroy
  has_many :idols, through: :relationships

  has_many :inverse_relationships, class_name: "Relationship", foreign_key: "idol_id", dependent: :destroy
  has_many :fans, through: :inverse_relationships, source: :author

  has_many :reaspas, dependent: :destroy
  has_many :citations, through: :reaspas, source: :raspa

  before_create do
    self.remember_token = SecureRandom.urlsafe_base64
    self.email.downcase! if email
    self.username = name.gsub(/\s+/, "")
  end

  def wall
    Raspa.wall_of(self)
  end

  def fan?(author)
    relationships.find_by(idol_id: author)
  end

  def fan!(author)
    relationships.create!(idol_id: author.id)
  end

  def unfan!(author)
    relationships.find_by(idol_id: author).destroy
  end

  # def to_s
  #   "#{first_name}"
  # end

  # def to_param
  #   "#{id}-#{name.parameterize}"
  # end

end
