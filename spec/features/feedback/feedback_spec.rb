describe 'Submitting a feedback' do
  before(:each) do
    visit new_feedback_url
  end

  it 'has required name field' do
    expect(page).to have_field('feedback_name')
    fill_in :feedback_email, with: 'u@e.com'
    fill_in :feedback_text, with: 'test'
    click_button 'Create Feedback'
    expect(page).not_to have_content 'Feedback was successfully sent!'
    expect(page).to have_content "can't be blank"
  end

  it 'has required email field' do
    expect(page).to have_field('feedback_email')
    fill_in :feedback_name, with: 'John'
    fill_in :feedback_text, with: 'test'
    click_button 'Create Feedback'
    expect(page).not_to have_content 'Feedback was successfully sent!'
    expect(page).to have_content "can't be blank"
  end

  it 'has required text field' do
    expect(page).to have_field('feedback_text')
    fill_in :feedback_name, with: 'John'
    fill_in :feedback_email, with: 'u@e.com'
    click_button 'Create Feedback'
    expect(page).not_to have_content 'Feedback was successfully sent!'
    expect(page).to have_content "can't be blank"
  end

  it 'succeeds' do
    fill_in :feedback_name, with: 'Richard Feynman'
    fill_in :feedback_email, with: 'user@example.com'
    fill_in :feedback_text, with: "Your app doesn't work!"
    click_button 'Create Feedback'
    expect(page).to have_content 'Feedback was successfully sent!'
  end

  it 'sends email' do
    fill_in :feedback_name, with: 'Richard Feynman'
    fill_in :feedback_email, with: 'user@example.com'
    fill_in :feedback_text, with: "Your app doesn't work!"
    click_button 'Create Feedback'
    expect(!ActionMailer::Base.deliveries.empty?).to eq true
  end

  context 'logged in' do
    let!(:user) { create(:user, full_name: 'John Smith', email: 'john@example.com', password: '123456') }

    before(:each) do
      login('john@example.com', '123456')
      visit new_feedback_url
    end

    it 'has prefilled inputs' do
      expect(page).to have_selector("input#feedback_name[value='John Smith']")
      expect(page).to have_selector("input#feedback_email[value='john@example.com']")
    end
  end
end
