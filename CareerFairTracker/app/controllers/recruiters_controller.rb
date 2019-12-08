class RecruitersController < ApplicationController
  before_action :set_recruiter, only: [:show, :edit, :update, :destroy]

  def index
    @recruiters = Recruiter.all
  end

  def show
  end

  def new
    @recruiter = Recruiter.new
  end

  def edit
  end

  def create
    @user = User.find(session[:user_id])
    @recruiter = Recruiter.new(recruiter_params)
    @recruiter.user = @user
    @recruiter.user_id = @user.id
    if not @recruiter.save!
      redirect_to root_url and return
    end
    session[:user_id_for_their_type] = @recruiter.id
    redirect_to recruiter_dashboard_path and return
  end

  def dashboard
    @user = current_user
    if @user == nil
      redirect_to root_url and return
    end
    @user_tag = @user[:username]
    @recruiter = Recruiter.find_by user_id: @user.id
    @user_type = @user[:user_type]
    @welcome_message = "Welcome #{@user_tag}"
  end

  def update
    respond_to do |format|
      if @recruiter.update(recruiter_params)
        format.html { redirect_to @recruiter, notice: 'Recruiter was successfully updated.' }
        format.json { render :show, status: :ok, location: @recruiter }
      else
        format.html { render :edit }
        format.json { render json: @recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recruiter.destroy
    respond_to do |format|
      format.html { redirect_to recruiters_url, notice: 'Recruiter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def select_event
    @events = Event.all
  end

  def generate_booth_code
    @booth_code = 1234
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recruiter
      @recruiter = Recruiter.find(params[:id])
    end

    def recruiter_params
      params.require(:recruiter).permit(:first_name, :last_name, :company_name, :email, :company_code)
    end
end
