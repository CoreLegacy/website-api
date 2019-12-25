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

        add_foreign_key :users, :users, column: "last_updated_by"
        add_foreign_key :roles, :users, column: "last_updated_by"
        add_foreign_key :privileges, :users, column: "last_updated_by"
        add_foreign_key :user_privileges, :users, column: "last_updated_by"
        add_foreign_key :staffs, :users, column: "last_updated_by"
        add_foreign_key :events, :users, column: "last_updated_by"
        add_foreign_key :texts, :users, column: "last_updated_by"
        add_foreign_key :media, :users, column: "last_updated_by"
        add_foreign_key :media_types, :users, column: "last_updated_by"
        add_foreign_key :views, :users, column: "last_updated_by"
        add_foreign_key :view_media, :users, column: "last_updated_by"
        add_foreign_key :view_texts, :users, column: "last_updated_by"
    end
end
