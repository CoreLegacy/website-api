class CreateImages < ActiveRecord::Migration[6.0]
    def change
        create_table :images do |t|
            t.string :checksum
            t.string :uri
            t.string :title
            t.datetime :created
            t.datetime :last_updated

            t.index :checksum, unique: true
        end
    end
end
