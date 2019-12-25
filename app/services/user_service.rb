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
end