require_relative './db_utility'
require_relative "../app/services/user_service"
include DbUtility
include UserService

DbUtility::upsert(Role.new(:name => Role::ADMIN))
DbUtility::upsert(Role.new(:name => Role::STAFF))
DbUtility::upsert(Role.new(:name => Role::MEMBER))

DbUtility::upsert(Privilege.new(:name => Privilege::MEDIA))
DbUtility::upsert(Privilege.new(:name => Privilege::TEXT))
DbUtility::upsert(Privilege.new(:name => Privilege::EVENTS))
DbUtility::upsert(Privilege.new(:name => Privilege::BLOG))

seed_user = User.new :first_name => "Database", :last_name => "Seeder", :email => "x@y.com", :password => "abc123", :role_id => Role.find_by(name: Role::ADMIN).id
puts seed_user.inspect
seed_user = DbUtility::upsert seed_user
puts seed_user.inspect
UserService::current_user = seed_user

airielle = DbUtility::upsert(User.new(:first_name => "Airielle", :last_name => "Dotson", :email => "airielle.dotson@gmail.com", :password => "password", :role_id => Role.find_by(:name => Role::ADMIN).id))
DbUtility::upsert(Staff.new(:title => "Director", :user_id => airielle.id))
Privilege.all.each do |privilege|
    DbUtility::upsert(UserPrivilege.new(:user_id => airielle.id, :privilege_id => privilege.id))
end

home_view = DbUtility::upsert(View.new(:name => "home"))
puts home_view.inspect
DbUtility::upsert(View.new(:name => "login"))
DbUtility::upsert(View.new(:name => "register"))
DbUtility::upsert(View.new(:name => "donate"))
DbUtility::upsert(View.new(:name => "about-contact"))
DbUtility::upsert(View.new(:name => "about-partners"))
DbUtility::upsert(View.new(:name => "about-story"))
DbUtility::upsert(View.new(:name => "about-team"))
DbUtility::upsert(View.new(:name => "contribute-financial"))
DbUtility::upsert(View.new(:name => "contribute-mentor"))
DbUtility::upsert(View.new(:name => "contribute-sponsor"))
DbUtility::upsert(View.new(:name => "contribute-volunteer"))

image_type = DbUtility::upsert(MediaType.new(mime_primary_type: "image", mime_sub_type: "jpg"))
video_type = DbUtility::upsert(MediaType.new(mime_primary_type: "video", mime_sub_type: "mp4"))
audio_type = DbUtility::upsert(MediaType.new(mime_primary_type: "audio", mime_sub_type: "mp3"))

home_banner = DbUtility::upsert(Medium.new(:uri => "banner_1200x650.jpg", :checksum => 1, :title => "home-banner", :media_type_id => image_type.id))

puts((DbUtility::upsert(ViewMedium.new(:view_id => home_view.id, :medium_id => home_banner.id, :identifier => "home-banner"))).inspect)