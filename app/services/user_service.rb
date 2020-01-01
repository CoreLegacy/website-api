require_relative "./service_base"

module UserService
    include ServiceBase

    def self.current_user
        Thread.current[:user] ? Thread.current[:user] : nil
    end

    def self.current_user=(user)
        if user
            Thread.current[:user] = user
        else
            Thread.current[:user] = nil
        end
    end

    def get(email)
        user = User.find_by email: email
        if user
            UserData.new user
        else
            nil
        end
    end

    def get_all
        result = []
        User.all.each do |user|
            result.push UserData.new user
        end

        result
    end

    def create(params)
        user = User.new
        user.email = params[:email]
        user.password = params[:password]
        user.first_name = params[:first_name]
        user.last_name = params[:last_name]
        user.active = true

        if params[:role]
            user.role_id = Role.find_by(name: params[:role]).id
        else
            user.role_id = Role.find_by(name: Role::MEMBER).id
        end

        user.save
        log "Created User: #{$/}\t#{user.inspect}"

        user
    end

    def update(user, params)
        user_params = [:first_name, :last_name, :email, :password]
        user_params.each do |key, value|
            if params[key]
                set_property user, key, value
            end
        end

        log "Updated User:  #{$/}\t#{user.inspect}"


        user.save
    end

    def authenticate(email, password)
        is_authenticated = false
        user = User.find_by :email => email
        log "Authenticating email '#{email}' and password '#{password}'#{$/}\t#{user.inspect}"
        if user && user.authenticate(password)
            is_authenticated = true
            log "Authenticated user's email and password via UserService::authenticate"
        end

        log "Unable to authenticate user" unless is_authenticated

        is_authenticated
    end

    def get_privileges(user)
        Privilege.joins(:user_privileges).where(user_privileges: { user_id: user.id }).to_a
    end
end