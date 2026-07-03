class PagesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_subject
  def index
    @pages = @subject.pages.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(subject_id: @subject.id)
    @subjects = Subject.all
    # Count only the pages that belong to the active subject
    @page_count = Page.where(subject_id: @subject.id).count + 1

  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page created successfully."
      redirect_to pages_path(subject_id: @subject.id)
    else
      @subjects = Subject.all
      @page_count = Page.where(subject_id: @subject.id).count + 1
      render :new
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subjects = Subject.all
    @page_count = Page.where(subject_id: @subject.id).count
  end

  def update 
    @page = Page.find(params[:id])
    if @page.update(page_params)
      flash[:notice] = "Page updated successfully."
      redirect_to page_path(subject_id: @subject.id)
    else
      @subjects = Subject.all
      @page_count = Page.where(subject_id: @subject.id).count
      render :edit
    end
  end

  def destroy
    @page = Page.find(params[:id])
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

end
