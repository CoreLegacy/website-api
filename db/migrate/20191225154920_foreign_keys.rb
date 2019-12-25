class ForeignKeys < ActiveRecord::Migration[6.0]
    def change
        add_foreign_key :users, :roles
        add_foreign_key :user_privileges, :users
        add_foreign_key :user_privileges, :privileges
        add_foreign_key :staffs, :users
        add_foreign_key :view_media, :media
        add_foreign_key :view_media, :views
        add_foreign_key :view_texts, :views
        add_foreign_key :view_texts, :texts
    end
end
