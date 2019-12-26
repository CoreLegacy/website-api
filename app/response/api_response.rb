class ApiResponse
    attr_reader :messages

    def initialize
        @messages = []
    end

    def add_message(message)
        unless self.messages
            @messages = []
        end
        @messages.push message
    end
end