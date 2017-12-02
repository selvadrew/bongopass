class AddEventCurrencyToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :event_currency, :string
  end
end
