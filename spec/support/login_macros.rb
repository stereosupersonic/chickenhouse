def login_as_admin
  admin = create(:admin)
  session[:user_id] = admin.id
  admin
end

def sign_in(user)
  visit root_path
  click_link 'Login'
  fill_in 'Username', with: user.username
  fill_in 'Password', with: user.password
  click_button 'Ok'
  page.should have_content "Signed in successfully."
end
