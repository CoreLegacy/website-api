class CreatePageImages < ActiveRecord::Migration[6.0]
    def change
        create_table :page_images do |t|
            t.string :element_id
            t.integer :page_id
            t.integer :image_id
            t.datetime :created
            t.datetime :last_updated
        end
    end
end
