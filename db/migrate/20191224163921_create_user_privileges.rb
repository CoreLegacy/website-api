class CreateUserPrivileges < ActiveRecord::Migration[6.0]
    def change
        create_table :user_privileges do |t|
            t.string :name
            t.integer :user_id
            t.integer :privilege_id
        end
    end
end
