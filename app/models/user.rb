class User < ApplicationRecord
  include Clearance::User

  belongs_to :profile, optional: true

  private

  def create_or_link_profile
    if self.confirmed? && self.unconfirmed_email.blank?
      existing_profile = Profile.where(email: self.email).first
      if existing_profile
        self.profile = existing_profile
        self.save
      else
        self.profile = Profile.create email: self.email
        self.save
      end
    end
  end
end
