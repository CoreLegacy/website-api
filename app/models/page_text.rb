class PageText < ActiveRecord::Base
    belongs_to :page, :class_name => 'Page', :foreign_key => :page_id
    belongs_to :text, :class_name => 'Text', :foreign_key => :text_id
end
