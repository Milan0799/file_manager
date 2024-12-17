class RegistrationsController < Devise::RegistrationsController
  def check_email
    email = params[:email]
    user = User.find_by(email: )

    if user
      render json: { available: false, message: 'Email is already taken' }
    else
      render json: { available: true }
    end
  end
end
