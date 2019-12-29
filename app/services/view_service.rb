require_relative "./service_base"

module ViewService
    include ServiceBase

    def get_view_data(name)
        view = View.find_by name: name

        ViewData.new view
    end

    def get_media_data(view)
        view_media = ViewMedium.where view_id: view.id

        media_data = []
        view_media.each do |view_medium|
            data = MediaData.new
            medium = Medium.find_by_id view_medium.medium_id
            data.media_type = MediaType.find_by_id medium.id
            data.uri = medium.uri
            data.identifier = view_medium.identifier
            media_data.push data
        end

        media_data
    end

    def get_texts_data(view)
        view_texts = ViewText.where view_id: view.id

        view_data = []
        view_texts.each do |view_text|
            data = ViewItem.new
            text = Text.find_by_id view_text.text_id
            data.content = text.content
            data.identifier = view_text.identifier
            view_data.push data
        end

        texts
    end

end