FactoryGirl.define do
  AUTHOR_NAME = 'Aaron'
  AUTHOR_SURNAME = 'Sumner'
  factory :author do
    firstname AUTHOR_NAME
    lastname AUTHOR_SURNAME
    biography "One day he became a programmer"
  end

end
