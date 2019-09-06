describe 'Listing feedbacks' do
  let!(:admin) { create(:user, full_name: 'Admin', email: 'admin@example.com',
                               password: '123456', is_admin: true) }

  before(:each) do
    login('admin@example.com', '123456')
    create(:feedback, name: 'John Smith', email: 'john@example.com', text: 'Hello')
    create(:feedback, name: 'Michael Brown', email: 'misha@example.com', text: 'Help')
    visit admin_feedbacks_url
  end

  it 'has pagination' do
    create_list(:feedback, 21)
    visit admin_feedbacks_url
    expect(page).to have_content('1')
    expect(page).to have_content('Next')
    expect(page).to have_content('Last')
  end

  it 'searches john' do
    fill_in :search_field, with: 'john'
    click_button 'Submit'
    expect(page).to have_content('Hello')
    expect(page).to have_content('john@example.com')
    expect(page).not_to have_content('Help')
    expect(page).not_to have_content('misha@example.com')
  end

  it 'searches Help' do
    fill_in :search_field, with: 'Help'
    click_button 'Submit'
    expect(page).to have_content('Help')
    expect(page).to have_content('misha@example.com')
    expect(page).not_to have_content('Hello')
    expect(page).not_to have_content('john@example.com')
  end
end
