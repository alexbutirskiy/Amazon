require 'rails_helper'

RSpec.describe UserCustomer, type: :model do
  it { should belong_to(:site_account) }
  it { should belong_to(:customer) }
end
