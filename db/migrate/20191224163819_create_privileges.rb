class CreatePrivileges < ActiveRecord::Migration[6.0]
    def change
        create_table :privileges do |t|
            t.string :name
        end
    end
end
