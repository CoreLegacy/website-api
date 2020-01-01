require_relative "../app/services/log_service"

module DbUtility
    include LogService

    def upsert(model)
        record = model
        type = model.class
        data = model.to_hash
        begin
            # Attempt to retrieve the record using the keys provided
            record = type.find_by data
            # If the record exists already, just update the fields
            # provided in the "data" hash and save it
            if record
                log "Updating #{type}: #{data}"
                data.each do |key, value|
                    record.send("#{key}=", value)
                end
                # If the record was NOT found, just create a new record
            else
                log "Inserting #{type}: #{data}"
                record = type.create data
            end

            record.save
            log "Finished upserting #{type}:#{$/}\t#{record.inspect}", false
        rescue => exception
            log "#{type}: unable to update model #{record.inspect}"
            log exception.to_s
        end

        if record.errors.any?
            log "Errors occurred while Upserting #{type}:", false
            record.errors.messages.each do |attribute, error|
                log "\t#{attribute}: #{error}", false
            end
        end


        record
    end


end