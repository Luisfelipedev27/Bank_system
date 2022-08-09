class CreateBankAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_accounts do |t|
      t.references :user, foreign_key: true
      t.decimal :balance
      t.string :account_number

      t.timestamps
    end
  end
end
