class UserCustomer < ActiveRecord::Base
  belongs_to :site_account, class_name: 'User', foreign_key: 'user_id'
  belongs_to :customer
end
