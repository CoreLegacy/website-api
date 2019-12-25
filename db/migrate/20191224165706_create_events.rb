class CreateEvents < ActiveRecord::Migration[6.0]
    def change
        create_table :events do |t|
            t.string :title
            t.string :description
            t.datetime :start
            t.datetime :end
            t.datetime :created
            t.datetime :last_updated
            t.integer :last_updated_by
        end
    end
end
