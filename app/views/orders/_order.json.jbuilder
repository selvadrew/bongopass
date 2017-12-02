json.extract! order, :id, :address, :city, :province, :created_at, :updated_at, :first_name, :last_name
json.url order_url(order, format: :json)
