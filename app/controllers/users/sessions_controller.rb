# frozen_string_literal: true
class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    
    if resource.student? 
      unless current_university == resource.university
        sign_out(resource)

        redirect_to new_user_session_path,
                notice: "Please sign in using your university domain."
        # redirect_to new_user_session_url(host: resource.university.domain.host),
        #         notice: "Please sign in using your university domain."
        return
      end
    else
      if resource.admin?
          unless current_domain.admin?
            sign_out(resource)
            admin_host = Domain.admin.first.host

            redirect_to new_user_session_url(host: admin_host),
                notice: "Admins must sign in from the admin domain."
            return
          end
      end
    end

    #  self.resource = warden.authenticate!(auth_options)
      
    #   if resource.student? && resource.university.domain.host != request.host
    #     sign_out resource
    #     redirect_to new_user_session_path,
    #                 notice: "Please sign in using your university's domain."
    #     return
    #   end
    sign_in(resource_name, resource)
    redirect_to after_sign_in_path_for(resource)
  end
  
  
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in)
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      universities_path 
    else
      university_path(resource.university) 
    end
  end

  def after_sign_out_path_for(scope)
    super(scope)
  end
end
