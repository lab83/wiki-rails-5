class Revision < ApplicationRecord
  belongs_to :page
  belongs_to :profile
end
