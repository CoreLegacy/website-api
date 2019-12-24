class CreateTexts < ActiveRecord::Migration[6.0]
    def change
        create_table :texts do |t|
            t.string :content
        end
    end
end
