class CreateStaffs < ActiveRecord::Migration[6.0]
    def change
        create_table :staffs do |t|
            t.string :title
            t.integer :user_id
        end
    end
end
