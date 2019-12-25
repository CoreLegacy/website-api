class CreateViewMedia < ActiveRecord::Migration[6.0]
    def change
        create_table :view_media do |t|
            t.string :identifier
            t.integer :view_id
            t.integer :medium_id
            t.datetime :created
            t.datetime :last_updated
        end
    end
end
