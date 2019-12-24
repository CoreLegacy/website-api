class CreatePrivileges < ActiveRecord::Migration[6.0]
    def change
        create_table :privileges do |t|
            t.string :name
            t.datetime :created
            t.datetime :last_updated
        end
    end
end
