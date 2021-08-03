# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # https://easyramble.com/implement-devise-and-ominiauth-on-rails.html
  # https://github.com/heartcombo/devise/blob/c82e4cf47b02002b2fd7ca31d441cf1043fc634c/app/controllers/devise/registrations_controller.rb#L97-L101
  def build_resource(hash = nil)
    hash[:uid] = User.create_unique_string if hash

    super(hash)
  end

  # Overwrite update_resource to let users to update their user without giving their password
  # ref: https://stackoverflow.com/questions/13436232/editing-users-with-devise-and-omniauth
  def update_resource(resource, params)
    if current_user.provider.blank?
      resource.update_with_password(params)
    else
      params.delete('current_password')
      resource.update_without_password(params)
    end
  end
end
