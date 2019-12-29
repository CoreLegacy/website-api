class DefaultMailer < ApplicationMailer

    def welcome_email
        user_id = params[:user_id]
        @user = User.find_by_id user_id
        log "Sending welcome email to #{@user.first_name} #{@user.last_name} at #{@user.email}"
        mail to: @user.email, subject: "Welcome to Core Legacy!"
    end

    def recover_password
        @key = params[:key]
        @user = User.find_by_id params[:user_id]

        mail to: @user.email, subject: "Reset Password at Core Legacy"
    end

end
