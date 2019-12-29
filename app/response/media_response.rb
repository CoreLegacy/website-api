class MediaResponse < ApiResponse
    attr_accessor :media

    def initialize
        super
        self.media = []
    end
end