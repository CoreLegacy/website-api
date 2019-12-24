class ForeignKeys < ActiveRecord::Migration[6.0]
    def change
        add_foreign_key :users, :roles
        add_foreign_key :user_privileges, :users
        add_foreign_key :user_privileges, :privileges
        add_foreign_key :staffs, :users
        add_foreign_key :page_images, :pages
        add_foreign_key :page_images, :images
        add_foreign_key :page_texts, :pages
        add_foreign_key :page_texts, :texts
    end
end
