class CreateImages < ActiveRecord::Migration[6.0]
    def change
        create_table :images do |t|
            t.string :hash
            t.string :uri
            t.string :title

            t.index :hash, unique: true
        end
    end
end
