require_relative "./media_data"
require_relative "./text_data"

class ViewData
    attr_accessor :media
    attr_accessor :texts
    attr_accessor :name
    attr_accessor :view

    def initialize(view)
        self.media = []
        self.texts = []
        self.name = nil
        if view
            self.name = view.name

            view_media = ViewMedium.where view_id: view.id
            view_media.each do |view_medium|
                log "View Medium: #{view_medium.inspect}"
                media_data = MediaData.new
                medium = Medium.find_by_id view_medium.medium_id
                media_data.identifier = view_medium.identifier
                media_data.uri = medium.uri
                media_data.media_type = MediaType.find_by_id(medium.media_type_id)
                self.media.push media_data
            end

            view_texts = ViewText.where view_id: view.id
            view_texts.each do |view_text|
                text_data = TextData.new
                text_data.identifier = view_text.identifier
                text_data.content = Text.find_by_id view_text.text_id
                self.texts.push text_data
            end
        end
    end
end