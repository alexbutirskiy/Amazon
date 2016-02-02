require 'rails_helper'
require 'acceptance/features/features_spec_helper'
require 'support/features_settings_helpers'
include Warden::Test::Helpers
#Capybara.default_driver = :selenium
Warden.test_mode!

feature 'Settings' do
  after(:each) do
    Warden.test_reset!
  end

  context 'When Customer is still not registered as Customer' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      login_as(@user, :scope => :user, :run_callbacks => false)
      visit '/'
    end

    context "when clicks on Settings link" do
      before(:each) do
        @customer = build(:customer)
        click_link('Settings')
      end

      it 'goes on settings page' do
        expect(page).to have_content('Settings')
      end

      it "shows 'Create Customer' form" do
        expect(page).to have_button('Create Customer')
      end

      it "doesn't display adress forms" do
        expect(page).to_not have_content('BILLING ADDRESS')
        expect(page).to_not have_content('SHIPPING ADDRESS')
      end

      scenario "Customer registers his name" do
        within('#new_customer') do
          fill_in 'Your firstname', with: @customer.firstname
          fill_in 'Your lastname',  with: @customer.lastname
          click_button ('Create Customer')
        end
        expect(find('.alert-success').text).to eq 'Customer has been created'
        expect(find_field('Your firstname').value).to eq @customer.firstname
        expect(find_field('Your lastname').value).to  eq @customer.lastname
      end

      scenario "Customer tries to register his name without lastname" do
        within('#new_customer') do
          fill_in 'Your firstname', with: @customer.firstname
          click_button ('Create Customer')
        end
        expect(find('.alert-danger').text).to eq "Lastname can't be blank"
        expect(find_field('Your firstname').value).to eq @customer.firstname
        expect(find_field('Your lastname').value).to  eq ''
      end

      scenario "Customer tries to register his name without firstname" do
        within('#new_customer') do
          fill_in 'Your lastname', with: @customer.lastname
          click_button ('Create Customer')
        end
        expect(find('.alert-danger').text).to eq "Firstname can't be blank"
        expect(find_field('Your firstname').value).to eq ''
        expect(find_field('Your lastname').value).to  eq @customer.lastname
      end

      test_email_update
      test_password_update
    end
  end

  context 'When Customer is already registered as Customer' do
    before(:each) do
      @user = create(:user)
      @user.update_attribute(:customer, create(:customer))
      login_as(@user, :scope => :user)
      @customer = build(:customer)
      @address = build(:address)
      visit '/'
      click_link('Settings')
    end

    scenario 'Customer goes on settings page' do
      expect(page).to have_content('Settings')
      expect(page).to have_content('CUSTOMER SETTINGS')
    end

    scenario "Customer sees 'Update Customer' form" do
      expect(page).to have_button('Update Customer')
    end

    scenario "Customer sees firstname and lastname in the 'Update Customer' form" do
      expect(find_field('Your firstname').value).to eq @user.customer.firstname
      expect(find_field('Your lastname').value).to  eq @user.customer.lastname
    end

    scenario "Customer sees adress forms" do
      expect(page).to have_content('BILLING ADDRESS')
      expect(page).to have_content('SHIPPING ADDRESS')
    end

    context 'When there are still no addresses registered' do
      test_address_form('billing_address',  'created')
      test_address_form('shipping_address', 'created')
    end

    context 'When addresses are registered' do
      before(:each) do
         @user.customer.billing_address  = create(:address)
         @user.customer.shipping_address = create(:address)
         @user.customer.save
         click_link('Settings')
      end

      test_address_form('billing_address',  'updated')
      test_address_form('shipping_address', 'updated')
    end

    test_email_update
    test_password_update
  end
end