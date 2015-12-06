require 'rails_helper.rb'

feature "user creates a new charge" do
	
	let!(:failed_charges) { CreditCardCharge.where(:paid => false, :refunded => false).count }
	let!(:disputed_charges) { CreditCardCharge.where(:paid => true, :refunded => true).count }
	let!(:successful_charges) { CreditCardCharge.where(:paid => true, :refunded => false).count }

	scenario "initial counting of failed charges" do
		visit root_path

		click_link "Failed Charges"

		expect(page).to have_selector('li.charges', count: failed_charges)
	end

	scenario "initial counting of disputed charges" do
		visit root_path

		click_link "Disputed Charges"

		expect(page).to have_selector('li.charges', count: disputed_charges)
	end

	scenario "initial counting of successful charges" do
		visit root_path

		click_link "Successful Charges"

		expect(page).to have_selector('li.charges', count: successful_charges)
	end

  scenario "submit a new charge" do
    visit new_credit_card_charge_path

    fill_in('Amount', :with => '999.99')

    option = first('#credit_card_charge_user_id option').text
    select option, from: 'credit_card_charge_user_id'

    click_button('Create Credit card charge')

    expect(CreditCardCharge.all.count).to eq successful_charges + 1
  end

end

