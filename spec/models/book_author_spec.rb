require 'rails_helper'

RSpec.describe BookAuthor, type: :model do
  context 'Attributes' do
    %w(book author).each do |attribute|
      it { should respond_to(attribute) }
    end
  end
end
