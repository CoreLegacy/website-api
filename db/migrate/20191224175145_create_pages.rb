class CreatePages < ActiveRecord::Migration[6.0]
    def change
        create_table :pages do |t|
            t.string :name
            t.datetime :created
            t.datetime :last_updated
        end
    end
end
