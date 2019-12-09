class StudentsController < ApplicationController
    def student_params
        params.require(:student).permit(:first_name, :last_name, :major, :expected_grad_month, :expected_grad_year)
    end

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

    def attend_event

    end

    def update
    end

    def destroy
    end
end
