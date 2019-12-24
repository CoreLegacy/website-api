Role.create :name => "superadmin"
Role.create :name => "staff"
Role.create :name => "member"
Role.create :name => "visitor"

Privilege.create :name => "images"
Privilege.create :name => "text"
Privilege.create :name => "events"
Privilege.create :name => "blogs"

airielle = User.create :first_name => "Airielle", :last_name => "Dotson", :email => "airielle.dotson@gmail.com", :password => "password", :role_id => Role.find_by(:name => "superadmin").id
Staff.create :title => "Director", :user_id => airielle.id
Privilege.all.each do |privilege|
    UserPrivilege.create :user_id => airielle.id, :privilege_id => privilege.id
end

Page.create :name => "home"
Page.create :name => "login"
Page.create :name => "register"
Page.create :name => "donate"
Page.create :name => "about-contact"
Page.create :name => "about-partners"
Page.create :name => "about-story"
Page.create :name => "about-team"
Page.create :name => "contribute-financial"
Page.create :name => "contribute-mentor"
Page.create :name => "contribute-sponsor"
Page.create :name => "contribute-volunteer"

Image.create :uri => "banner_1200x650.jpg", :checksum => 1, :title => "home-banner"