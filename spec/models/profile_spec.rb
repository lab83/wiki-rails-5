require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :created_at }
    it { is_expected.to respond_to :updated_at }
  end

  describe 'associations' do
    it { is_expected.to have_many :revisions }
    it { is_expected.to have_one(:user).dependent(:destroy) }
  end
end
