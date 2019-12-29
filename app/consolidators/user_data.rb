class UserData
    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :email
    attr_accessor :role
    attr_accessor :privileges

    def initialize(user)
        if user
            self.first_name = user.first_name
            self.last_name = user.last_name
            self.email = user.email
            self.role = Role.find_by_id(user.role_id).name
            self.privileges = Privilege.joins(:user_privileges).where(user_privileges: { user_id: user.id }).map { |privilege| privilege.name }
        end
    end
end