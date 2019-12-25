class CreateUserPrivileges < ActiveRecord::Migration[6.0]
    def change
        create_table :user_privileges do |t|
            t.integer :user_id
            t.integer :privilege_id
            t.datetime :created
            t.datetime :last_updated
            t.integer :last_updated_by
        end
    end
end
