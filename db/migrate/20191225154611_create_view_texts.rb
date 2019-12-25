class CreateViewTexts < ActiveRecord::Migration[6.0]
    def change
        create_table :view_texts do |t|
            t.string :identifier
            t.integer :view_id
            t.integer :text_id
            t.datetime :created
            t.datetime :last_updated
        end
    end
end
