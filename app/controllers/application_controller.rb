class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_current_domain

  helper_method :current_domain, :current_university

  private

  def set_current_domain
    @current_domain = Domain.includes(:university).find_by(host: request.host)
    unless @current_domain
      render file: Rails.public_path.join("404.html"),
             status: :not_found,
             layout: false
    end
  end

  def current_domain
    @current_domain
  end

  def current_university
    @current_domain&.university
  end

  # def require_admin_domain
  #   unless current_domain.admin?
  #     redirect_to root_path, notice: "Admin portal only."
  #   end
  # end

  # def require_university_domain
  #   unless current_domain.university?
  #     redirect_to root_path, notice: "Student portal only."
  #   end
  # end

end
