require 'rails_helper'

RSpec.describe Revision, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to :title }
    it { is_expected.to respond_to :slug }
    it { is_expected.to respond_to :body }
    it { is_expected.to respond_to :page_id }
    it { is_expected.to respond_to :profile_id }
    it { is_expected.to respond_to :created_at }
    it { is_expected.to respond_to :updated_at }
  end

  describe 'associations' do
    it { is_expected.to belong_to :page }
    it { is_expected.to belong_to :profile }
  end
end
