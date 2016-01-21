require 'rails_helper'

describe 'routing to authors' do
  it "routes / to books#show_bestseller with id: '1'" do
    expect(get: '/authors/1').to route_to(
      controller: 'authors',
      action: 'show', 
      id: '1')
  end

  test_denied(
    '/authors/1': [:delete, :update, :put],
    '/authors': [:get, :delete, :update, :put]
  )
end