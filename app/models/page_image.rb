class PageImage < ActiveRecord::Base
    belongs_to :page, :class_name => 'Page', :foreign_key => :page_id
    belongs_to :image, :class_name => 'Image', :foreign_key => :image_id
end
