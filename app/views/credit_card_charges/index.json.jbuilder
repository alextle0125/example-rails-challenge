json.array!(@credit_card_charges) do |credit_card_charge|
  json.extract! credit_card_charge, :id, :amount, :unique_code, :paid, :refunded, :user_id, :company_id
  json.url credit_card_charge_url(credit_card_charge, format: :json)
end
