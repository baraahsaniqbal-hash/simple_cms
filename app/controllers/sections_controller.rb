class SectionsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_page

  def index
    @sections = @page.sections
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new(page_id: @page.id)
    @pages = @page.subject.pages
    @section_count = Section.where(page_id: @page.id).count + 1
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section created successfully."
      redirect_to sections_path(page_id: @page.id)
    else
      @pages = @page.subject.pages
      @section_count = Section.where(page_id: @page.id).count + 1
      render :new
    end
  end

  def edit
    @section = Section.find(params[:id])
    @pages = @page.subject.pages
    @section_count = Section.where(page_id: @page.id).count
  end

  def update 
    @section = Section.find(params[:id])
    if @section.update(section_params)
      flash[:notice] = "Section updated successfully."
      redirect_to section_path(page_id: @page.id)
    else
      @pages = @page.subject.pages
      @section_count = Section.where(page_id: @page.id).count
      render :edit
    end
  end

  def destroy
    @section = Section.find(params[:id])
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

end
