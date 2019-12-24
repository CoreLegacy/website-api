class CreateUsers < ActiveRecord::Migration[6.0]
    def change
        create_table :users do |t|
            t.string :first_name
            t.string :last_name
            t.string :email
            t.datetime :created
            t.string :password
            t.integer :role_id
        end
    end
end
