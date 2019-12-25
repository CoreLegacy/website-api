class CreateMedia < ActiveRecord::Migration[6.0]
    def change
        create_table :media do |t|
            t.integer :media_type_id
            t.string :checksum
            t.string :uri
            t.string :title
            t.datetime :created
            t.datetime :last_updated
            t.integer :last_updated_by
        end
    end
end
