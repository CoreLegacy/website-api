module LogService

    def log(log)
        if log.is_a?(String) || log.is_a?(Numeric)
            puts log
        else
            puts log.inspect
        end
    end
end