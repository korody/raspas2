class UserProfile < ActiveRecord::Base

  has_one :author, as: :profile, dependent: :destroy

  has_secure_password

  validates :password, presence: { on: :create }, length: { minimum: 4, allow_blank: true }
  validates :email, presence: true, length: { maximum: 60 }, email_format: true, uniqueness: { case_sensitive: false }

  before_create do
    self.email.downcase! if email
  end

  accepts_nested_attributes_for :author

  def legend?
    false
  end

  def send_password_reset
    self.reset_token = SecureRandom.urlsafe_base64
    self.reset_token_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end


end
