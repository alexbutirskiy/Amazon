require 'rails_helper'
require 'acceptance/features/features_spec_helper'

include Warden::Test::Helpers
#Capybara.default_driver = :selenium
Warden.test_mode!

feature 'Reviews' do
  let(:book) { create(:book) }

  after(:each) do
    Warden.test_reset!
  end

  context 'when User is not signed in' do
    it "redirects to 'sign in' page" do
      visit "/books/#{book.id}/reviews/new"
      expect(current_path).to eq "/users/sign_in"
    end
  end

  context 'when User is signed in' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      login_as(@user, scope: :user, run_callbacks: false)
    end

    context 'when User has an empty Customer profile' do
      it "redirects to 'Settings' page" do
        visit "/books/#{book.id}/reviews/new"
        expect(find('.alert-danger').text).to eq "Register your name first"
        expect(current_path).to eq "/users/#{@user.id}/customer/edit"
      end
    end

    context 'when User has already have Customer profile' do
      before(:each) do
        @user.update_attribute(:customer, create(:customer))
        visit "/books/#{book.id}/reviews/new"
      end

      it "goes to 'new' page" do
        expect(current_path).to eq "/books/#{book.id}/reviews/new"
      end

      scenario "User adds new review with required field 'Title'" do
        review = build(:review)

        within('#new_review') do
          fill_in 'Title', with: review.title
          fill_in 'Text', with: review.text
          click_button 'ADD'
        end
        expect(find('.alert-success').text).to eq "Review has been cerated"
        expect(page).to have_content review.title
        expect(page).to have_content review.text
      end

      scenario "User adds new review without required field 'Title'" do
        review = build(:review)

        within('#new_review') do
          fill_in 'Text', with: review.text
          click_button 'ADD'
        end

        expect(current_path).to eq "/books/#{book.id}/reviews"
        expect(find('.alert-danger').text).to eq "Title can't be blank"
        expect(page).to have_content review.text
      end
    end
  end  
end