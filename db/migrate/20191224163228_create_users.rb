class CreateUsers < ActiveRecord::Migration[6.0]
    def change
        create_table :users do |t|
            t.string :first_name
            t.string :last_name
            t.string :email
            t.string :password
            t.integer :role_id
            t.datetime :created
            t.datetime :last_updated
            t.integer :last_updated_by
        end
    end
end
