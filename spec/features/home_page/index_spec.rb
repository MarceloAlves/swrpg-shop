describe 'index page', type: :feature, js: true do
  it 'has content' do
    visit root_path
    expect(page).to have_content 'Quickly and easily generate shopping lists for players'
  end
end
