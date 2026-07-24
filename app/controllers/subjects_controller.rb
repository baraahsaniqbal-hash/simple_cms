class SubjectsController < ApplicationController
  # before_action :require_admin_domain!,only: %i[new create edit update destroy]
  before_action :authenticate_user!
  before_action :check_admin, only:[:new, :create, :edit, :update, :destroy]
  before_action :set_subjects, only: [:show, :edit, :update, :destroy]
  # before_action :autherize_subject!, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin?
      @pagy, @subjects = pagy(Subject.order(:position), limit: 10)
    else
      @pagy, @subjects = pagy(current_user.university.subjects, limit: 10) 
    end
  end

  def show
  end

  def new
    @subject = Subject.new
    @subject_count = Subject.count + 1
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:notice] = "Subject created successfully."
      redirect_to subjects_path
    else
      @subject_count = Subject.count + 1
      render :new
    end
  end

  def edit
    @subject_count = Subject.count
  end

  def update 
    if @subject.update(subject_params)
      flash[:notice] = "Subject updated successfully."
      redirect_to subject_path(@subject.id)
    else
      @subject_count = Subject.count
      render :edit
    end
  end

  def destroy
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' destroyed successfully."
    redirect_to subjects_path
  end

  def add 
    @subject = Subject.find(params[:id]) 
    current_user.subjects << @subject unless current_user.subjects.exists?(@subject.id) 
    redirect_to subjects_path  
  end

  def remove 
    @subject = Subject.find(params[:id]) 
    current_user.subjects.delete(@subject) 
    redirect_to university_path(current_user.university) 
  end
  private 

  def subject_params 
    params.require(:subject).permit(:name, :position, :visible, university_ids: []) 
  end

  def set_subjects
    @subject = Subject.find(params[:id])
  end

  def check_admin
    unless current_user.admin? 
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to subjects_path
    end
  end
  
  # def autherize_subject!
  #   unless current_user.admin? || @subject.user == current_user
  #     flash[:alert] = "You are not authorized to perform this action."
  #     redirect_to subjects_path
  #   end
  # end

end