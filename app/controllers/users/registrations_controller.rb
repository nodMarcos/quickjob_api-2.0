class Users::RegistrationsController < Devise::RegistrationsController
  Devise::RegistrationsController

  respond_to :json
  private

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render 'users/show', locals: { user: resource }, status: :created

    else
      render json: {
        status: {message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end
end