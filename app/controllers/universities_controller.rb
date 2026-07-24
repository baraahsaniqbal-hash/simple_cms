class UniversitiesController < ApplicationController
  # before_action :require_admin_domain,only: %i[new create edit update destroy]
  before_action :authenticate_user!,only: %i[new create show edit update destroy]
  before_action :check_admin, only: %i[new create edit update destroy]
  before_action :set_university, only: %i[ show edit update destroy ]
  before_action :set_students_subjects, only: %i[ show]
  
  # GET /universities
  def index
    @pagy, @universities = pagy(University.includes(:domain).order(id: :desc), limit: 5)
  end

  # GET /universities/1
  def show
  end

  # GET /universities/new
  def new
    @university = University.new
    @university.build_domain
  end

  # GET /universities/1/edit
  def edit
  end

  # POST /universities
  def create
    @university = University.new(university_params)

    respond_to do |format|
      if @university.save
        flash.now[:notice] = "University created successfully."
        @pagy, @universities = pagy(University.includes(:domain).order(id: :desc), limit: 5)
        format.js 
        format.html {redirect_to @university, notice: "University was successfully created."}
      else
        format.js
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /universities/1
  def update
    respond_to do |format|
      if @university.update(university_params)
        flash.now[:notice] = "University updated successfully."
        @pagy, @universities = pagy(University.includes(:domain).order(id: :desc), limit: 5)
        format.js
        format.html { redirect_to @university, notice: "University was successfully updated."}
      else
        format.js
        format.html { render :edit, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /universities/1
  def destroy
    @university.destroy
    flash.now[:notice] = "University deleted successfully."
    @pagy, @universities = pagy(University.includes(:domain).order(id: :desc), limit: 5)

    respond_to do |format|
      format.js 
      format.html{ redirect_to universities_path, status: :see_other, notice: "University was successfully destroyed." }
    end
  end

  private

  def set_university
    if current_user.admin?
      @university = University.friendly.find(params[:id])
    else
      @university = current_university
    end
  end

  def set_students_subjects
    if current_user.admin? 
      @subjects = @university.subjects.includes(:users)
    else
      @subjects = current_user.subjects
    end
    @pagy, @subjects = pagy(@subjects, limit: 5)
  end

  def university_params
    params.require(:university).permit(:name, domain_attributes: [:id, :host])
  end

  def check_admin
    redirect_to root_path, alert: "Access denied." unless current_user&.admin?
  end
end
