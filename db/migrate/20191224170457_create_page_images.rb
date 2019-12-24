class CreatePageImages < ActiveRecord::Migration[6.0]
    def change
        create_table :page_images do |t|
            t.string :element_id
            t.integer :page_id
            t.integer :image_id
        end
    end
end
