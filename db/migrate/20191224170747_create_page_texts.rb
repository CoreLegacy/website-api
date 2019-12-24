class CreatePageTexts < ActiveRecord::Migration[6.0]
    def change
        create_table :page_texts do |t|
            t.string :element_id
            t.integer :page_id
            t.integer :text_id
        end
    end
end
