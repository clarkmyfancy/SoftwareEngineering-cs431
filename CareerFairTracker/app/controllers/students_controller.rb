class StudentsController < ApplicationController
    before_action :set_student, only: [:show, :edit, :update, :destroy]

    def index
        @students = Student.all 
    end

    def show
        @student = Student.find(params[:id])
    end

    def new 
        @student = Student.new
    end

    def edit
    end

    def create
        @user = User.find(session[:user_id])
        @student = Student.new(student_params)
        @student.user = @user
        @student.user_id = @user.id
        if @student.save!
            redirect_to student_path(@student) and return
        end
        session[:user_id_for_their_type] = @student.id
        redirect_to student_dashboard_path and return
    end

    def dashboard
        @user = current_user
        if @user == nil
            redirect_to root_url and return
        end
        @user_tag = @user[:username]
        @student = Student.find_by user_id: @user.id
        @user_type = @user[:user_type]
        @welcome_message = "Welcome #{@user_tag}"
    end

    def update
        respond_to do |format|
            if @student.update(student_params)
                format.html { redirect_to @student, notice: 'Student was successfully updated.' }
                format.json { render :show, status: :ok, location: @student }
            else
                format.html { render :edit }
                format.json { render json: @student.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @student.destroy
        respond_to do |format|
            format.heml { redirect_tto students_url, notice: 'Student was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private

    def set_student
        @student = Student.find(params[:id])
    end

    def student_params
        params.require(:student).permit(:first_name, :last_name, :major, :expected_grad_month, :expected_grad_year)
    end
end
