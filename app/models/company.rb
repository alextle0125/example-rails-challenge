class Company < ActiveRecord::Base
	has_many :credit_card_charge
end
