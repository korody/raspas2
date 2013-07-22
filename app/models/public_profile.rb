class PublicProfile < ActiveRecord::Base
  has_one :author, as: :profile, dependent: :destroy

  accepts_nested_attributes_for :author

  def legend?
    true
  end

  def become_user
    author.profile = UserProfile.create
    author.save!
  end

end
