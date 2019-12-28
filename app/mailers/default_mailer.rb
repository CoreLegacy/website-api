class DefaultMailer < ApplicationMailer

    def welcome_email
        user_id = params[:user_id]
        @user = User.find user_id
        log "Sending welcome email to #{@user.first_name} #{@user.last_name} at #{@user.email}"
        mail to: @user.email, subject: "Welcome to Core Legacy!"
    end

end
