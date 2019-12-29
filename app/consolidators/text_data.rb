require_relative "./view_item"

class TextData < ViewItem
    attr_accessor :content

    def initialize(text = nil)
        super text
        if text
            self.content = text.content
        end
    end
end