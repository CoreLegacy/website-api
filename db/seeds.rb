require_relative './db_utility'
require_relative "../app/services/user_service"
require_relative "../app/services/log_service"
include DbUtility
include UserService
include LogService

Role.constants(false).map(&Role.method(:const_get)).each do |role|
    DbUtility::upsert(Role.new(:name => role))
end

Privilege.constants(false).map(&Privilege.method(:const_get)).each do |privilege|
    DbUtility::upsert(Privilege.new(:name => privilege))
end

seed_user = User.new :first_name => "Database", :last_name => "Seeder", :email => "x@y.com", :password => "abc123", :role_id => Role.find_by(name: Role::ADMIN).id, :active => false
log seed_user.inspect
seed_user = DbUtility::upsert seed_user
log seed_user.inspect
UserService::current_user = seed_user

airielle = DbUtility::upsert(User.new(:first_name => "Airielle", :last_name => "Dotson", :email => "airielle.dotson@gmail.com", :password => "Password123", :role_id => Role.find_by(:name => Role::ADMIN).id, :active => true))
DbUtility::upsert(Staff.new(:title => "Director", :user_id => airielle.id))
matt = DbUtility::upsert(User.new(:first_name => "Matthew", :last_name => "Shoemaker", :email => "shoemaker.277@osu.edu", :password => "Password123", :role_id => Role.find_by(:name => Role::ADMIN).id, :active => true))
DbUtility::upsert(Staff.new(:title => "Director of Technology", :user_id => matt.id))
Privilege.all.each do |privilege|
    DbUtility::upsert(UserPrivilege.new(:user_id => airielle.id, :privilege_id => privilege.id))
    DbUtility::upsert(UserPrivilege.new(:user_id => matt.id, :privilege_id => privilege.id))
end

home_view = DbUtility::upsert(View.new(:name => "home"))
log home_view.inspect
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

home_banner = DbUtility::upsert(Medium.new(:uri => "banner_1200x650.jpg", :checksum => 1, :title => "home-banner", :media_type => image_type))

log((DbUtility::upsert(ViewMedium.new(:view_id => home_view.id, :medium_id => home_banner.id, :identifier => "home-banner"))).inspect)