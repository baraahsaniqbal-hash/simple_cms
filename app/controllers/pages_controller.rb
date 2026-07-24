class PagesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_subject
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:show, :edit, :update, :destroy]
  before_action :subject_selection_between_admin_and_user, only: [:new, :create, :edit, :update]
  
  def index
    @pages = @subject.pages.sorted
  end

  def show
  end

  def new
    @page = Page.new(subject_id: @subject.id)
    @page_count = Page.where(subject_id: params[:subject_id]).count + 1

  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page created successfully."
      redirect_to pages_path(subject_id: @subject.id)
    else
      @page_count = Page.where(subject_id: params[:subject_id]).count + 1
      render :new
    end
  end

  def edit
    @page_count = Page.where(subject_id: params[:subject_id]).count

  end

  def update 
    if @page.update(page_params)
      flash[:notice] = "Page updated successfully."
      redirect_to page_path(subject_id: @subject.id)
    else
      @page_count = Page.where(subject_id: params[:subject_id]).count 
      render :edit
    end
  end

  def destroy
    @page.destroy
    flash[:notice] = "Page '#{@page.name}' destroyed successfully."
    redirect_to pages_path(subject_id: @subject.id)
  end

  private 

  def page_params 
    params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible) 
  end

  def find_subject
    @subject = Subject.find(params[:subject_id])
  end

  def set_page
    @page = Page.find(params[:id])
  end

  def require_same_user
    if current_user.admin? || current_user == @page.subject.user
      return true
    else
      flash[:alert] = "You can only edit or delete your own pages."
      redirect_to pages_path(subject_id: @subject.id)
    end
  end

  def subject_selection_between_admin_and_user
    if current_user.admin?
      @subjects = Subject.order(:user_id, :position)
    else
      @subjects = current_user.subjects.sorted
    end
  end

end
