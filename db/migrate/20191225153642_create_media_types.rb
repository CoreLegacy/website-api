class CreateMediaTypes < ActiveRecord::Migration[6.0]
    def change
        create_table :media_types do |t|
            t.string :mime_primary_type
            t.string :mime_sub_type
            t.datetime :created
            t.datetime :last_updated
            t.integer :last_updated_by
        end
    end
end
