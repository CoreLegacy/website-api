class CreateAmazonCredentials < ActiveRecord::Migration[6.0]
    def change
        create_table :amazon_credentials do |t|
            t.string :access_key_id
            t.string :secret_access_key
            t.string :bucket_name
            t.string :user
        end
    end
end
