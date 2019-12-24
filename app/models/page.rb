class Page < ActiveRecord::Base
    has_many :page_images, :class_name => 'PageImage'
    has_many :page_texts, :class_name => 'PageText'
end
