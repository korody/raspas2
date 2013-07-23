# encoding: utf-8
class Author < ActiveRecord::Base
  
  validates_presence_of :name
  validates_format_of :username, with: /^[A-Za-z\d_]+$/, multiline: true, message: "só pode conter letras e números, sem espaços.", on: :update

  has_many :raspas
  has_many :origins

  has_many :experiences, dependent: :destroy
  has_many :jobs, through: :experiences

  has_many :relationships, dependent: :destroy
  has_many :idols, through: :relationships

  has_many :inverse_relationships, class_name: "Relationship", foreign_key: "idol_id", dependent: :destroy
  has_many :fans, through: :inverse_relationships, source: :author

  has_many :reaspas, dependent: :destroy
  has_many :citations, through: :reaspas, source: :raspa

  belongs_to :profile, polymorphic: true

  delegate :legend?, :email, :password, :password_digest, :aka, :dod, :become_user, to: :profile, allow_nil: true

  before_create do
    self.remember_token = SecureRandom.urlsafe_base64
    self.username = name.gsub(/\s+/, "").downcase
  end

  before_update do
    self.username = username.downcase
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

  def reciter?(raspa)
    reaspas.find_by(raspa_id: raspa)
  end

  def recite!(raspa)
    reaspas.create!(raspa_id: raspa.id)
  end

  def uncite!(raspa)
    reaspas.find_by(raspa_id: raspa).destroy
  end

  def has_jobs
    jobs.map(&:name).join(", ")
  end

  def has_jobs=(names)
    self.jobs = names.split(",").map do |j|
      Job.where(name: j.strip).first_or_create!
    end
  end

  # def to_s
  #   "#{first_name}"
  # end

end
