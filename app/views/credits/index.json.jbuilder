json.array!(@credits) do |credit|
  json.extract! credit, :id, :email, :amount, :term, :payment, :status
  json.url credit_url(credit, format: :json)
end
