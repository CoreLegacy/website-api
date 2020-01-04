class CreateExceptionLogs < ActiveRecord::Migration[6.0]
    def change
        create_table :exception_logs do |t|
            t.datetime :created
            t.datetime :last_updated
            t.integer :last_updated_by
            t.integer :user_id
            t.string :token_payload
            t.string :log_message
            t.string :exception_message
            t.string :stacktrace
            t.string :ip_address
            t.string :request
            t.string :response
            t.string :params
        end
    end
end
