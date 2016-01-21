require 'rails_helper'

describe 'routing to books' do
  it "routes / to books#show_bestseller with id: '1'" do
    expect(get: '/').to route_to(
      controller: 'books',
      action: 'show_bestseller', 
      id: '1')
  end

  it 'routes /books to books#index' do
    expect(get: '/books').to route_to(
      controller: 'books',
      action: 'index'
      )
  end

  it 'routes /books/:id to books#show' do
    expect(get: '/books/1').to route_to(
      controller: 'books',
      action: 'show',
      id: '1')
  end

  it 'routes /books/bestseller/:id to books#show_bestseller' do
    expect(get: '/books/bestsellers/1').to route_to(
      controller: 'books', 
      action: 'show_bestseller', 
      id: '1')
  end

  test_denied(
    '/books/1': [:delete, :update, :put],
    '/books/bestsellers': [:delete, :update, :put]
  )
end