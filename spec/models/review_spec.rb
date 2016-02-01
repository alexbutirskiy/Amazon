require 'rails_helper'

RSpec.describe Review, type: :model, focus: false do
  context 'Attributes' do
    %w(title text value).each do |attribute|
      it { should have_db_column(attribute) }
      it { should respond_to(attribute) }
    end
  end

  context 'Validations' do
    it do
      should validate_numericality_of(:value)
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(10)
    end
  end

  context 'Associations' do
    %w(book customer).each do |association|
      it { should belong_to(association) }
    end
  end
end
