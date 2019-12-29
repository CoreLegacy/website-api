require_relative "./view_item"

class MediaData < Consolidator
    attr_accessor :media_type
    attr_accessor :uri
    attr_accessor :file_extension
    attr_accessor :checksum
    attr_accessor :title

    def initialize(medium = nil)
        super medium
        if medium
            self.media_type = MediaType.find_by_id medium.media_type_id
            self.uri = medium.uri
            self.file_extension = medium.file_extension
            self.checksum = medium.checksum
            self.title = medium.title
        end
    end
end