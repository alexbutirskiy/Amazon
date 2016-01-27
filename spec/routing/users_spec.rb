require 'rails_helper'

describe 'routing to users' do
  it 'routes get: /users/sign_in to devise/sessions#new' do
    expect(get: '/users/sign_in').to route_to(
      controller: 'devise/sessions',
      action: 'new'
      )
  end

  it 'routes post: /users/sign_in to devise/sessions#create' do
    expect(post: '/users/sign_in').to route_to(
      controller: 'devise/sessions',
      action: 'create'
      )
  end

  it 'routes delete: /users/sign_out to devise/sessions#destroy' do
    expect(delete: '/users/sign_out').to route_to(
      controller: 'devise/sessions',
      action: 'destroy'
      )
  end

  it 'routes get: /users/cancel to devise/registrations#cancel' do
    expect(get: '/users/cancel').to route_to(
      controller: 'devise/registrations',
      action: 'cancel'
      )
  end

  it 'routes post: /users to devise/registrations#new' do
    expect(post: '/users').to route_to(
      controller: 'devise/registrations',
      action: 'create'
      )
  end

  it 'routes get: /users/sign_up to devise/registrations#create' do
    expect(get: '/users/sign_up').to route_to(
      controller: 'devise/registrations',
      action: 'new'
      )
  end

  it 'routes get: /users/edit to devise/registrations#create' do
    expect(get: '/users/edit').to route_to(
      controller: 'devise/registrations',
      action: 'edit'
      )
  end

  test_denied(
    '/users/edit': [ :delete, :update, :put],
    '/users/password/new': [:get],
    '/users/password/edit': [:get],
    '/users/password': [:update, :put]
  )
end