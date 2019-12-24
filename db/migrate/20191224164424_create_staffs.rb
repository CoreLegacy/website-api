class CreateStaffs < ActiveRecord::Migration[6.0]
    def change
        create_table :staffs do |t|
            t.string :title
            t.integer :user_id
            t.datetime :created
            t.datetime :last_updated
        end
    end
end
