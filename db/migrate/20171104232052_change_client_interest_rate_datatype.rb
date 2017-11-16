class ChangeClientInterestRateDatatype < ActiveRecord::Migration
  def change
    change_column :clients, :interest_rate, :decimal
  end
end
