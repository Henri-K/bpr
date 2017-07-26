json.extract! client, :id, :name, :email, :down_payment, :down_payment_type, :interest_rate, :amort, :agent_id, :created_at, :updated_at
json.url client_url(client, format: :json)
