require 'rails_helper.rb'

feature "all lists for the different credit cards should be displayed" do
  scenario "find list for 'Failed Charges'" do
    visit root_path

    expect(find_link("Failed Charges")).to be_truthy
  end

  scenario "find list for 'Disputed Charges'" do
    visit root_path

    expect(find_link("Disputed Charges")).to be_truthy
  end

  scenario "find list for 'Disputed Charges'" do
    visit root_path

    expect(find_link("Successful Charges")).to be_truthy
  end
end

