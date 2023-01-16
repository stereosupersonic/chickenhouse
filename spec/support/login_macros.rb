def sign_in(user)
  visit login_path

  fill_in "Username", with: user.username
  fill_in "Password", with: user.password

  click_button "Ok"
end
