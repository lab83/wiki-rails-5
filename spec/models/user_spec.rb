require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :encrypted_password }
    it { is_expected.to respond_to :reset_password_token }
    it { is_expected.to respond_to :reset_password_sent_at }
    it { is_expected.to respond_to :remember_created_at }
    it { is_expected.to respond_to :sign_in_count }
    it { is_expected.to respond_to :current_sign_in_at }
    it { is_expected.to respond_to :last_sign_in_at }
    it { is_expected.to respond_to :current_sign_in_ip }
    it { is_expected.to respond_to :last_sign_in_ip }
    it { is_expected.to respond_to :confirmation_token }
    it { is_expected.to respond_to :confirmed_at }
    it { is_expected.to respond_to :confirmation_sent_at }
    it { is_expected.to respond_to :unconfirmed_email }
    it { is_expected.to respond_to :failed_attempts }
    it { is_expected.to respond_to :unlock_token }
    it { is_expected.to respond_to :locked_at }
    it { is_expected.to respond_to :administrator }
    it { is_expected.to respond_to :profile_id }
    it { is_expected.to respond_to :created_at }
    it { is_expected.to respond_to :updated_at }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:profile) }
  end

  describe 'callbacks' do
    context 'creating a new user' do
      before do
        @user = FactoryGirl.build(
          :valid_user,
          email: 'user@example.com',
          confirmed_at: Time.now,
          unconfirmed_email: nil
        )
      end

      context "a profile with the user's email already exists" do
        before do
          @profile = FactoryGirl.create :valid_profile, email: 'user@example.com'
        end

        context "new user's email is confirmed" do
          before do
            @user.unconfirmed_email = nil
            @user.save
            @user.reload
          end

          it 'links the user to the existing profile' do
            expect(@user.profile).to eq @profile
          end

          it "does not create another profile with the user's email" do
            expect(Profile.where(email: @user.email).count).to eq 1
          end
        end

        context "new user's email is not confirmed" do
          before do
            @user.unconfirmed_email = @user.email
            @user.save
            @user.reload
          end

          it 'does not link the user to the existing profile' do
            expect(@user.profile).to eq nil
          end

          it "does not create another profile with the user's email" do
            expect(Profile.where(email: @user.email).count).to eq 1
          end
        end
      end

      context "a profile with the user's email does not already exist" do
        before do
          Profile.where(email: @user.email).destroy_all
        end

        context "new user's email is confirmed" do
          before do
            @user.unconfirmed_email = nil
            @user.save
            @user.reload
          end

          it "creates a new linked profile with the user's email" do
            expect(@user.profile.email).to eq @user.email
          end
        end

        context "new user's email is not confirmed" do
          before do
            @user.unconfirmed_email = @user.email
            @user.save
            @user.reload
          end

          it "does not create a new linked profile with the user's email" do
            expect(Profile.where(email: @user.email).count).to eq 0
          end
        end
      end
    end

    context 'updating a user' do
      before do
        @profile_with_old_email = FactoryGirl.create(
          :valid_profile, email: 'old@example.com'
        )
        @user = FactoryGirl.create(
          :valid_user,
          email: 'old@example.com',
          confirmed_at: Time.now,
          unconfirmed_email: nil,
          profile: @profile_with_old_email
        )
      end

      context "a profile with the user's new email already exists" do
        before do
          @profile_with_new_email = FactoryGirl.create(
            :valid_profile, email: 'new@example.com'
          )
        end

        context "the user's new email is confirmed" do
          before do
            @user.email = 'new@example.com'
            @user.save
            @user.confirm
            @user.reload
          end

          it 'links the user to the profile with the new email' do
            expect(@user.profile).to eq @profile_with_new_email
          end

          it 'unlinks the user from the profile with the old email' do
            expect(@user.profile).not_to eq @profile_with_old_email
          end

          it "does not create another profile with the user's new email" do
            expect(Profile.where(email: @user.email).count).to eq 1
          end
        end

        context "the user's new email is not confirmed" do
          before do
            @user.email = 'new@example.com'
            @user.save
            @user.reload
          end

          it 'does not link the user to the profile with the new email' do
            expect(@user.profile).not_to eq @profile_with_new_email
          end

          it 'does not unlink the user from the profile with the old email' do
            expect(@user.profile).to eq @profile_with_old_email
          end

          it "does not create another profile with the user's new email" do
            expect(Profile.where(email: @user.email).count).to eq 1
          end
        end
      end

      context "a profile with the user's new email does not already exist" do
        before do
          Profile.where(email: 'new@example.com').destroy_all
        end

        context "the user's new email is confirmed" do
          before do
            @user.email = 'new@example.com'
            @user.save
            @user.confirm
            @user.reload
          end

          it "creates a new linked profile with the user's new email" do
            expect(@user.profile.email).to eq 'new@example.com'
          end
        end

        context "the user's new email is not confirmed" do
          before do
            @user.email = 'new@example.com'
            @user.save
            @user.reload
          end

          it "does not create a new linked profile with the user's new email" do
            expect(Profile.where(email: 'new@example.com').count).to eq 0
          end
        end
      end
    end
  end
end
