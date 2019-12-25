module DbUtility

    # This method will either update an existing record or it will
    # create a new record if one does not already exist. It will pass
    # the "keys" parameter as the argument to the "find_by" function
    # of the active record class specified by type. If the record is
    # found, it will update the fields specified by the "data" hash.
    # If the record is not found, it will create a new record for the
    # active record.
    #
    # type:
    #   the class of the active record to be queried against
    # keys:
    #   a hash of the fields used to identify the record
    # data:
    #   a hash of the data to be saved in the record
    def upsert_data(type, keys, data)
        puts "Upserting #{type}: \n\tKeys: #{keys}\n\tData: #{data}"


        # Attempt to retrieve the record using the keys provided
        record = type.find_by keys
        # If the record exists already, just update the fields
        # provided in the "data" hash and save it
        if record
            puts "Updating #{type}: #{data}"
            data.each do |key, value|
                record.send("#{key}=", value)
            end
            record.save
            # If the record was NOT found, just create a new record
        else
            puts "Inserting #{type}: #{data}"
            record = type.create data
            record.save
        end

        record
    end

    def upsert(model)
        record = model
        type   = model.class
        data   = model.to_hash
        begin
            # Attempt to retrieve the record using the keys provided
            record = type.find_by data
            # If the record exists already, just update the fields
            # provided in the "data" hash and save it
            if record
                puts "Updating #{type}: #{data}"
                data.each do |key, value|
                    record.send("#{key}=", value)
                end
                record.save
                # If the record was NOT found, just create a new record
            else
                puts "Inserting #{type}: #{data}"
                record = type.create data
                record.save
            end
        rescue => exception
            puts "#{type}: unable to update model #{record.inspect}"
            puts exception.to_s
        end

        record
    end


end