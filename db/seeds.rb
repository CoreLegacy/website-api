require_relative './db_utility'
require_relative "../app/services/user_service"
include DbUtility
include UserService

DbUtility.upsert(Role.new(:name => "superadmin"))
DbUtility.upsert(Role.new(:name => "staff"))
DbUtility.upsert(Role.new(:name => "member"))
DbUtility.upsert(Role.new(:name => "visitor"))

DbUtility.upsert(Privilege.new(:name => "images"))
DbUtility.upsert(Privilege.new(:name => "text"))
DbUtility.upsert(Privilege.new(:name => "events"))
DbUtility.upsert(Privilege.new(:name => "blogs"))

seed_user = User.new :first_name => "Database", :last_name => "Seeder", :email => "x@y.com", :password => "123", :role_id => 1
puts seed_user.inspect
seed_user = DbUtility.upsert seed_user
puts seed_user.inspect
UserService.current_user = seed_user

airielle = DbUtility.upsert(User.new(:first_name => "Airielle", :last_name => "Dotson", :email => "airielle.dotson@gmail.com", :password => "password", :role_id => Role.find_by(:name => "superadmin").id))
DbUtility.upsert(Staff.new(:title => "Director", :user_id => airielle.id))
Privilege.all.each do |privilege|
    DbUtility.upsert(UserPrivilege.new(:user_id => airielle.id, :privilege_id => privilege.id))
end

home_view = DbUtility.upsert(View.new(:name => "home"))
puts home_view.inspect
DbUtility.upsert(View.new(:name => "login"))
DbUtility.upsert(View.new(:name => "register"))
DbUtility.upsert(View.new(:name => "donate"))
DbUtility.upsert(View.new(:name => "about-contact"))
DbUtility.upsert(View.new(:name => "about-partners"))
DbUtility.upsert(View.new(:name => "about-story"))
DbUtility.upsert(View.new(:name => "about-team"))
DbUtility.upsert(View.new(:name => "contribute-financial"))
DbUtility.upsert(View.new(:name => "contribute-mentor"))
DbUtility.upsert(View.new(:name => "contribute-sponsor"))
DbUtility.upsert(View.new(:name => "contribute-volunteer"))

image_type = DbUtility.upsert(MediaType.new(:description => MediaType::IMAGE_DESC))
video_type = DbUtility.upsert(MediaType.new(:description => MediaType::VIDEO_DESC))
audio_type = DbUtility.upsert(MediaType.new(:description => MediaType::AUDIO_DESC))

home_banner = DbUtility.upsert(Medium.new(:uri => "banner_1200x650.jpg", :checksum => 1, :title => "home-banner", :media_type_id => image_type.id))

puts((DbUtility.upsert(ViewMedium.new(:view_id => home_view.id, :medium_id => home_banner.id, :identifier => "home-banner"))).inspect)