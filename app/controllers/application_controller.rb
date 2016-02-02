class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def display_flash(object, on_success = 'Ok')
    if object.errors.empty?
      flash.now[:notice] = on_success
    else
      flash.now[:alert] = object.errors.full_messages.join(', ')
    end
  end
end
