class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception


  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def after_sign_up_path_for(resource)
    if current_user.admin?
      Season.count == 0 ? "/seasons/new" : "/seasons/"# <- Path you want to redirect the user to.
    else
      "/teams/"
    end
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      Season.count == 0 ? "/seasons/new" : "/seasons/"# <- Path you want to redirect the user to.
    else
      user_path(resource)
    end
  end

  protected

  def configure_permitted_parameters
    puts "toto"
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :mobile, :photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :mobile, :photo])
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
