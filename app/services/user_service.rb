module UserService
    def self.current_user
        puts "Getting current user"
        Thread.current[:user] ? Thread.current[:user] : nil
    end

    def self.current_user=(user)
        if user
            Thread.current[:user] = user
        else
            Thread.current[:user] = nil
        end
    end

    def get(user_id)
        user = User.find user_id
        if user
            user = UserData.new user
        else
            nil
        end
    end

    def create(params)
        user = User.new
        user.email = params[:email]
        user.password = params[:password]
        user.first_name = params[:first_name]
        user.last_name = params[:last_name]

        puts params.inspect

        if params[:role]
            user.role_id = Role.find_by(name: params[:role]).id
        else
            user.role_id = Role.find_by(name: Role::MEMBER).id
        end

        puts user.save.inspect
        user
    end

    def authenticate(email, password)
        user = User.find_by :email => email
        LogService::log user
        if user
            user = user.authenticate(password)
            user = UserData.new user
        else
            user = nil
        end

        user
    end

    def get_privileges(user)
        Privilege.joins(:user_privileges).where(user_privileges: { user_id: user.id }).to_a
    end
end