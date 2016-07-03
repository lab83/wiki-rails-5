class Profile < ApplicationRecord
  has_many :revisions, dependent: :destroy
  has_one :user, dependent: :destroy
end
