def login(email, password)
  visit root_path
  click_link 'Sign in'
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_button 'Sign in'
end
