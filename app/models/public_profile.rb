class PublicProfile < ActiveRecord::Base
  has_one :author, as: :profile, dependent: :destroy

  accepts_nested_attributes_for :author

  # delegate :name, :username, :remember_token, :has_jobs, :dob, :social, :website, :bio, to: :author, allow_nil: true

  def legend?
    true
  end

  def become_user
    author.profile = UserProfile.create
    author.save!
  end

end
