class PublicController < ApplicationController

  # layout 'public'
  # before_action :authenticate_user!
  # before_action :set_navigation
  def index
  end

  def show
    @page = Page.where(permalink: params[:permalink], visible: true).first
    if @page.nil?
      redirect_to root_path
    else
      
    end
  end

  private
    def set_navigation
      @subjects = Subject.visible.sorted
    end
end
