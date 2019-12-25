class CreateViews < ActiveRecord::Migration[6.0]
    def change
        create_table :views do |t|
            t.string :name
            t.datetime :created
            t.datetime :last_updated
            t.integer :last_updated_by
        end
    end
end
