require 'rails_helper'

RSpec.describe Page, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to :title }
    it { is_expected.to respond_to :slug }
    it { is_expected.to respond_to :created_at }
    it { is_expected.to respond_to :updated_at }
  end

  describe 'associations' do
    it { is_expected.to have_many(:revisions).dependent(:destroy) }
  end
end
