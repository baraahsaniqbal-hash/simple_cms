# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :set_university, only: [:new, :create]
  # GET /resource/sign_up
  def new
    build_resource({})
  end

  # POST /resource
  def create

    build_resource(sign_up_params)
    resource.university = @university

    if resource.save
      sign_up(resource_name, resource)
      redirect_to university_path(resource.university)
    else
      render :new
    end

    # @university = University.friendly.find(params[:slug])
    # @university = University.find(session[:university_id])

  #   build_resource(sign_up_params)
  #   resource.university = @university

  #   if resource.save
  #     # Clean up after successful signup
  #     session.delete(:university_id)
  #     sign_up(resource_name, resource)
  #     redirect_to university_path(resource.university) 

  #   else
  #     render :new
  #   end
  
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :university_id])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   subjects_path
  # end

  # def set_university
  #   if params[:slug].present?
  #     @university = University.friendly.find_by!(slug: params[:slug])
  #     session[:university_id] = @university.id
  #   elsif session[:university_id].present?
  #     @university = University.find(session[:university_id])
  #   else
  #     redirect_to root_path, alert: "Invalid or expired registration link."
  #   end
  # end
  
  def set_university
    unless current_university
      redirect_to root_path, notice: "Registration is only available from a university domain."
      return
    end

    @university = current_university
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
