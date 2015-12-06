json.array!(@companies) do |company|
  json.extract! company, :id, :name, :zip_code
  json.url company_url(company, format: :json)
end
