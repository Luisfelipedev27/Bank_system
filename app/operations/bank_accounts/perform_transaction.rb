module BankAccounts
  class PerformTransaction
    def initialize(amount:, transaction_type:, bank_account_id:, recipient_id:)
      @amount = amount.try(:to_f)
      @transaction_type = transaction_type
      @bank_account_id = bank_account_id
      @recipient_id = recipient_id
      @bank_account = BankAccount.where(id: bank_account_id).first
      @recipient_account = BankAccount.where(account_number: recipient_id).first
    end

    def create_transaction!(bank_account, amount, transaction_type, recipient_id)
        AccountTransaction.create!(
          bank_account: bank_account,
          amount: amount,
          transaction_type: transaction_type,
          recipient_id: recipient_id
        )
        tax_nine_to_eighteen = 5
        #tax_another_time = 7 Pendente
        #tax_greater_than_thousand = 10 #Pendente
        bank_account.update(balance: bank_account.balance - amount) if transaction_type == "Saque"
        bank_account.update(balance: bank_account.balance - amount - tax_nine_to_eighteen) if transaction_type == "Transferencia" 
        bank_account.update(balance: bank_account.balance + amount) if transaction_type == "Depósito"
      raise ActiveRecord::Rollback unless bank_account.present?
    end

    def execute!
      if %w(Saque Depósito Transferencia).include?(@transaction_type)
        ActiveRecord::Base.transaction do
          create_transaction!(@bank_account, @amount, @transaction_type, @recipient_id)
        end
      end
      @bank_account 
    end
  end
end