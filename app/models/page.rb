class Page < ApplicationRecord
  has_many :revisions, dependent: :destroy
end
