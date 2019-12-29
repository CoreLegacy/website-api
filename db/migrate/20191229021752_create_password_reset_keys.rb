class CreatePasswordResetKeys < ActiveRecord::Migration[6.0]
    def change
        create_table :password_reset_keys do |t|
            t.string :reset_key
            t.integer :user_id
            t.boolean :active
            t.datetime :created
            t.datetime :last_updated
            t.integer :last_updated_by
        end

        add_foreign_key :password_reset_keys, :users
    end
end
