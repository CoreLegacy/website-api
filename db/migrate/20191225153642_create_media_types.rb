class CreateMediaTypes < ActiveRecord::Migration[6.0]
    def change
        create_table :media_types do |t|
            t.string :description
            t.datetime :created
            t.datetime :last_updated
            t.integer :last_updated_by
        end
    end
end
