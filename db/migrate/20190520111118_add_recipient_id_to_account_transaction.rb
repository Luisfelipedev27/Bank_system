class AddRecipientIdToAccountTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :account_transactions, :recipient_id, :string
  end
end
