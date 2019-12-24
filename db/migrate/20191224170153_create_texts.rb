class CreateTexts < ActiveRecord::Migration[6.0]
    def change
        create_table :texts do |t|
            t.string :content
            t.datetime :created
            t.datetime :last_updated
        end
    end
end
