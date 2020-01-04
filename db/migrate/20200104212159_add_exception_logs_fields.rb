class AddExceptionLogsFields < ActiveRecord::Migration[6.0]
    def change
        add_column :exception_logs, :raw_request, :string
        add_column :exception_logs, :raw_response, :string
        add_column :exception_logs, :severity, :integer
        add_column :exception_logs, :response_body, :string
        add_column :exception_logs, :request_params, :string
    end
end
