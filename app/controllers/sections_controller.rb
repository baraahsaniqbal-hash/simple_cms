class SectionsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_page
  before_action :set_section, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:show, :edit, :update, :destroy]
  before_action :page_for_admin_and_user, only: [:new, :create, :edit, :update]
  before_action :set_pages, only: [:new, :create, :edit, :update]
  def index
    @sections = @page.sections
  end

  def show
  end

  def new
    @section = Section.new(page_id: @page.id)
     # Count only the sections that belong to the active page
    @section_count = Section.where(page_id: params[:page_id]).count + 1
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section created successfully."
      redirect_to sections_path(page_id: @page.id)
    else
      # Count only the sections that belong to the active page
      @section_count = Section.where(page_id: params[:page_id]).count + 1
      render :new
    end
  end

  def edit
    # Count only the sections that belong to the active page
    @section_count = Section.where(page_id: params[:page_id]).count
  end

  def update 
    if @section.update(section_params)
      flash[:notice] = "Section updated successfully."
      redirect_to section_path(page_id: @page.id)
    else
      # Count only the sections that belong to the active page
      @section_count = Section.where(page_id: params[:page_id]).count
      render :edit
    end
  end

  def destroy
    @section.destroy
    flash[:notice] = "Section '#{@section.name}' destroyed successfully."
    redirect_to sections_path(page_id: @page.id)
  end

  private 

  def section_params 
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content) 
  end

  def find_page
    @page = Page.find(params[:page_id])
  end

  def set_section
    @section = Section.find(params[:id])
  end
  
  def set_pages
    @pages = @page.subject.pages
  end

  def require_same_user
    if current_user != @page.subject.user && !current_user.admin?
      flash[:alert] = "You can only view and edit your own sections."
      redirect_to root_path
    end
  end

  def page_for_admin_and_user
    if current_user.admin?
      @pages = Page.order(:subject_id, :position)
    else
      @pages = current_user.pages.order(:subject_id, :position)
    end
  end

end
